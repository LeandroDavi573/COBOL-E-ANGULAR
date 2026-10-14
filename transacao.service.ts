import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Transacao } from './transacao';

@Injectable({ providedIn: 'root' })
export class TransacaoService {
  private http = inject(HttpClient);

  // Lê o arquivo que o COBOL gerou (fica na pasta public/)
  listar() {
    return this.http.get<Transacao[]>('transacoes.json');
  }
}
