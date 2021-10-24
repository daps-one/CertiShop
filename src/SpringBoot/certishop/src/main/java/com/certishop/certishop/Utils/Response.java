package com.certishop.certishop.Utils;

public class Response {
    
    private Number status;
    
    private Integer modelId;

    private String description;

    public Response(Number status, String description, Integer modelId) {
        this.status = status;
        this.description = description;
        this.modelId = modelId;
    }

    public Response(Number status, String description) {
        this.status = status;
        this.description = description;
    }

    public Number getStatus() {
        return status;
    }

    public void setStatus(Number status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getModelId() {
        return modelId;
    }

    public void setModelId(Integer modelId) {
        this.modelId = modelId;
    }
}
