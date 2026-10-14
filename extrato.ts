import { Component, computed, inject } from '@angular/core';
import { CurrencyPipe } from '@angular/common';
import { toSignal } from '@angular/core/rxjs-interop';
import { TransacaoService } from '../transacao.service';

@Component({
  selector: 'app-extrato',
  imports: [CurrencyPipe],
  templateUrl: './extrato.html',
  styleUrl: './extrato.css',
})
export class Extrato {
  private service = inject(TransacaoService);

  // A lista vira um signal: começa vazia e se atualiza quando o JSON chega
  transacoes = toSignal(this.service.listar(), { initialValue: [] });

  // Soma em centavos (inteiros) para não cair no 0.1 + 0.2
  totalValido = computed(() => {
    const centavos = this.transacoes()
      .filter(t => t.status === 'V')
      .reduce((soma, t) => soma + Math.round(t.valor * 100), 0);
    return centavos / 100;
  });

  rejeitadas = computed(() => this.transacoes().filter(t => t.status === 'R').length);
}
