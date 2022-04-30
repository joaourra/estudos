package com.dio.model;

import java.util.Objects;

public class Gato {

	private String nome;
	private String cor;
	private Integer idade;

	// Ctrl 3 - busca = construc (constructor fields)

	public Gato(String nome, String cor, Integer idade) {
		super();
		this.nome = nome;
		this.cor = cor;
		this.idade = idade;
	}

	// Ctrl 3 - gett (generate getters and setters

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCor() {
		return cor;
	}

	public void setCor(String cor) {
		this.cor = cor;
	}

	public Integer getIdade() {
		return idade;
	}

	public void setIdade(Integer idade) {
		this.idade = idade;
	}

	// Ctrl 3 - equals (Generate equals e hashCode

	@Override
	public int hashCode() {
		return Objects.hash(cor, idade, nome);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Gato other = (Gato) obj;
		return Objects.equals(cor, other.cor) && Objects.equals(idade, other.idade) && Objects.equals(nome, other.nome);
	}

	// Ctrl 3 - toStr (generate String...)

	@Override
	public String toString() {
		return "Gato [nome=" + nome + ", cor=" + cor + ", idade=" + idade + ", getNome()=" + getNome() + ", getCor()="
				+ getCor() + ", getIdade()=" + getIdade() + ", hashCode()=" + hashCode() + ", getClass()=" + getClass()
				+ ", toString()=" + super.toString() + "]";
	}

	// Seleciona o que quer mudar segura Alt e seta para Cima ou baixo mover

	// Ctrs Shift + F (Organiza tudo)
}
