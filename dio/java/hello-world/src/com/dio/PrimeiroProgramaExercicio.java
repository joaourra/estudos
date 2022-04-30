package com.dio;

import com.dio.model.Gato;

public class PrimeiroProgramaExercicio {

	public static void main(String[] args) {
		// Ctrl Shift O (Importa a classe)
		
		Gato gato = new Gato(null, null, null);
		Livros livros = new Livros();
		System.out.println("Hello, world!" + gato + livros);
	}

}
class Livros {
	private String nome;
	private String npag;
}