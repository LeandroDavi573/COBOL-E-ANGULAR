// Espelho do copybook TRANSACAO
export interface Transacao {
  id: string;          // TRN-ID      PIC 9(05)
  cliente: string;     // TRN-CLI     PIC 9(05)
  valor: number;       // TRN-VALOR   PIC 9(07)V99
  status: 'V' | 'R';   // TRN-STATUS  88 VALIDA / 88 REJEITADA
}
