# Extrato COBOL → Angular

Tela em Angular que lê o `transacoes.json` gerado por um programa COBOL.

## Rodar
1. Instale o Node.js 22 ou superior.
2. Nesta pasta: `npm install`
3. Depois: `npx ng serve`
4. Abra http://localhost:4200

## Onde está cada coisa
- `public/transacoes.json`: o arquivo que o COBOL gera. Troque pelo seu.
- `src/app/transacao.ts`: a interface, espelho do copybook.
- `src/app/transacao.service.ts`: busca o JSON.
- `src/app/extrato/`: a tela (componente, template e estilo).
- `src/app/app.config.ts`: HttpClient e formato brasileiro (pt-BR).
