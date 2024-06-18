package br.com.nathanflp.ecommerce.enums;

public enum statusContaPagar {
    COBRANCA("Pagar"),
    VENCIDA("Vencida"),
    ABERTA("Aberta"),
    QUITADA("Quitada"),
    RENEGOCIADA("Renegoiada");

    private String descricao;

    private statusContaPagar(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }

    @Override
    public String toString() {
        return this.descricao;
    }
}
