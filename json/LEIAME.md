# GERAJSON - COBOL gerando JSON para o Angular

Arquivos:
- TRANSACAO.cpy  : copybook com o layout do registro (20 posicoes)
- GERAJSON.cbl   : programa que le transacoes.dat e grava transacoes.json
- transacoes.dat : 5 transacoes de exemplo

Rodar com GnuCOBOL (Windows, Linux ou Mac), nesta pasta:
    cobc -x -o gerajson GERAJSON.cbl
    ./gerajson          (no Windows: gerajson.exe)

Depois copie o transacoes.json gerado para a pasta public/ do projeto Angular.

Layout do registro (transacoes.dat):
    posicao 1-5   TRN-ID      PIC 9(05)
    posicao 6-10  TRN-CLI     PIC 9(05)
    posicao 11-19 TRN-VALOR   PIC 9(07)V99   (000015075 = 150,75)
    posicao 20    TRN-STATUS  PIC X          (V = valida, R = rejeitada)
