package com.dio.santander.bankline.api.service;

import com.dio.santander.bankline.api.dto.NovoCorrentista;
import com.dio.santander.bankline.api.model.Conta;
import com.dio.santander.bankline.api.model.Correntista;
import com.dio.santander.bankline.api.repository.CorrentistaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class CorrentistaService {
    @Autowired
    private CorrentistaRepository repository;
    public void save(NovoCorrentista novoCorrentista){
        Correntista correntista = new Correntista();
        correntista.setCpf(novoCorrentista.getCpf()); //set determina e get recebe a informação
        correntista.setNome(novoCorrentista.getNome());

        //criando uma conta para o correntista
        Conta conta = new Conta();
        conta.setSaldo(0.0);
        conta.setNumero(new Date().getTime());

        correntista.setConta(conta);
        repository.save(correntista);
    }
}
