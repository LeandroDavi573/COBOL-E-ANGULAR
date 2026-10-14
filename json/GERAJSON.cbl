       IDENTIFICATION DIVISION.
       PROGRAM-ID. GERAJSON.
      *----------------------------------------------------------*
      * Le transacoes.dat (registro fixo de 20 posicoes) e grava *
      * transacoes.json, uma lista no formato que o Angular le.  *
      *----------------------------------------------------------*
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-ENTRADA ASSIGN TO '..\transacoes.dat'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ENT.
           SELECT ARQ-SAIDA   ASSIGN TO
               '..\..\extrato-cobol\public\transacoes.json'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-SAI.

       DATA DIVISION.
       FILE SECTION.
       FD  ARQ-ENTRADA.
           COPY TRANSACAO.

       FD  ARQ-SAIDA.
       01  REG-SAIDA          PIC X(100).

       WORKING-STORAGE SECTION.
       01  WS-FS-ENT          PIC XX.
       01  WS-FS-SAI          PIC XX.
       01  WS-FIM             PIC X     VALUE 'N'.
           88 FIM-ARQUIVO               VALUE 'S'.
       01  WS-VALOR-ED        PIC Z(6)9.99.
       01  WS-LINHA           PIC X(100).
       01  WS-QTD             PIC 9(05) VALUE ZERO.

       PROCEDURE DIVISION.
       0000-PRINCIPAL.
           OPEN INPUT  ARQ-ENTRADA
                OUTPUT ARQ-SAIDA
           IF WS-FS-ENT NOT = '00'
              DISPLAY 'ERRO AO ABRIR transacoes.dat - FS ' WS-FS-ENT
              STOP RUN
           END-IF

           MOVE '[' TO REG-SAIDA
           WRITE REG-SAIDA

           PERFORM 1000-LER
           PERFORM 2000-PROCESSAR UNTIL FIM-ARQUIVO

           MOVE ']' TO REG-SAIDA
           WRITE REG-SAIDA

           CLOSE ARQ-ENTRADA ARQ-SAIDA
           DISPLAY 'TRANSACOES GRAVADAS NO JSON: ' WS-QTD
           STOP RUN.

       1000-LER.
           READ ARQ-ENTRADA
               AT END SET FIM-ARQUIVO TO TRUE
           END-READ.

      *----------------------------------------------------------*
      * Monta a linha, le a PROXIMA transacao e so entao grava:  *
      * se ainda existe proxima, a linha leva virgula no final.  *
      *----------------------------------------------------------*
       2000-PROCESSAR.
           ADD 1 TO WS-QTD
           PERFORM 2100-MONTAR-JSON
           PERFORM 1000-LER

           MOVE SPACES TO REG-SAIDA
           IF FIM-ARQUIVO
              STRING '  '     DELIMITED BY SIZE
                     WS-LINHA DELIMITED BY SPACE
                     INTO REG-SAIDA
              END-STRING
           ELSE
              STRING '  '     DELIMITED BY SIZE
                     WS-LINHA DELIMITED BY SPACE
                     ','      DELIMITED BY SIZE
                     INTO REG-SAIDA
              END-STRING
           END-IF
           WRITE REG-SAIDA.

       2100-MONTAR-JSON.
           MOVE TRN-VALOR TO WS-VALOR-ED
           MOVE SPACES    TO WS-LINHA
           STRING '{"id":"'                  DELIMITED BY SIZE
                  TRN-ID                     DELIMITED BY SIZE
                  '","cliente":"'            DELIMITED BY SIZE
                  TRN-CLI                    DELIMITED BY SIZE
                  '","valor":'               DELIMITED BY SIZE
                  FUNCTION TRIM(WS-VALOR-ED) DELIMITED BY SIZE
                  ',"status":"'              DELIMITED BY SIZE
                  TRN-STATUS                 DELIMITED BY SIZE
                  '"}'                       DELIMITED BY SIZE
                  INTO WS-LINHA
           END-STRING.
