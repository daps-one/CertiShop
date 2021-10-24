package com.certishop.certishop.Controllers;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.certishop.certishop.Repositories.*;
import com.certishop.certishop.Repositories.TransactionRepository.ITransactionRepository;
import com.certishop.certishop.Utils.Response;
import com.certishop.certishop.Entities.Product;
import com.certishop.certishop.Entities.Transactions;
import com.certishop.certishop.Entities.TransactionDetail;
import com.certishop.certishop.Entities.User;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/api")
public class TransactionController {

    private final ITransactionRepository transactionRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final TransactionDetailRepository transactionDetailRepository;
    private final FranchiseRepository franchiseRepository;
    private final Integer maxTotalPriceTransaction = 10000000;
    private final Integer maxTodayPriceTransaction = 5000000;

    public TransactionController(ITransactionRepository transactionRepository, ProductRepository productRepository,
            UserRepository userRepository, TransactionDetailRepository transactionDetailRepository,
            FranchiseRepository franchiseRepository) {
        this.transactionRepository = transactionRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
        this.transactionDetailRepository = transactionDetailRepository;
        this.franchiseRepository = franchiseRepository;
    }

    @PostMapping("/addTransaction")
    public ResponseEntity<Response> addTransaction(@Valid @RequestBody Transactions entity) {
        try {
            Date currentDate = new Date();
            entity.getUser().setStatus(true);
            entity.setTransactionDate(currentDate);
            entity.setFranchise(franchiseRepository.findById(entity.getFranchise().getFranchiseId()).get());
            Integer totalPrice = 0;
            for (TransactionDetail detail : entity.getTransactionsDetails()) {
                Integer productId = detail.getProduct().getProductId();

                Optional<Product> product = productRepository.findById(productId);
                if (product == null) {
                    entity.getTransactionsDetails().remove(detail.getProduct());
                    continue;
                }
                detail.setProduct(product.get());
                detail.setUnitPrice(product.get().getUnitPrice());
                detail.setTotalPrice(detail.getAmount() * product.get().getUnitPrice());
                totalPrice += detail.getTotalPrice();
            }
            entity.setTotalPrice(totalPrice);
            if (entity.getTotalPrice() > maxTotalPriceTransaction) {
                return ResponseEntity.ok(new Response(0, "La transacción no puede superar los 10 millones de pesos"));
            }

            Optional<User> user = userRepository.findByIdentificationNumber(entity.getUser().getIdentificationNumber());
            if (!user.isEmpty()) {
                entity.setUser(user.get());
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(currentDate);
                List<Transactions> transactionsByUser = transactionRepository.findByUserAndDate(
                        entity.getUser().getUserId(), calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1);
                if (transactionsByUser.size() > 4) {
                    return ResponseEntity
                            .ok(new Response(0, "Ha superado el número máximo (5) de transacciónes el día de hoy"));
                }

                Integer countTransactionToday = 0;
                for (Transactions currentTransaction : transactionsByUser) {
                    countTransactionToday += currentTransaction.getTotalPrice();
                }

                if (countTransactionToday > maxTodayPriceTransaction) {
                    return ResponseEntity.ok(new Response(0,
                            "Ha superado el monto maximo díario (" + maxTodayPriceTransaction + " pesos)"));
                }
            } else {
                userRepository.save(entity.getUser());
            }

            Set<TransactionDetail> temp = entity.getTransactionsDetails();
            entity = transactionRepository.save(new Transactions(entity.getcreditCardNumber(),
                    entity.getExpirationDate(), entity.getFees(), entity.getTotalPrice(), entity.getObservations(),
                    entity.getTransactionDate(), entity.getFranchise(), entity.getUser()));

            for (TransactionDetail transactionTemp : temp) {
                transactionTemp.setTransactions(entity);
            }
            transactionDetailRepository.saveAll(temp);
            return ResponseEntity
                    .ok(new Response(1, "Transacción aprobada satisfactoriamente", entity.getTransactionId()));
        } catch (Exception e) {
            return new ResponseEntity<Response>(new Response(400, "Error al ingresar los datos en la base de datos"),
                    HttpStatus.BAD_REQUEST);
        }
    }

}
