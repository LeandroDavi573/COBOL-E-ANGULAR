      *----------------------------------------------------------*
      * COPYBOOK TRANSACAO - registro fixo de 20 posicoes        *
      *----------------------------------------------------------*
       01  REG-TRANSACAO.
           05 TRN-ID          PIC 9(05).
           05 TRN-CLI         PIC 9(05).
           05 TRN-VALOR       PIC 9(07)V99.
           05 TRN-STATUS      PIC X.
              88 VALIDA       VALUE 'V'.
              88 REJEITADA    VALUE 'R'.
