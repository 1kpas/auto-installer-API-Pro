const http = require("http");

// URL de destino no GitHub Raw
const targetURL = "https://raw.githubusercontent.com/1kpas/auto-installer-API-Pro/main/initial";

// Porta onde o servidor irá rodar
const PORT = 3000;

// Criar servidor HTTP
http.createServer((req, res) => {
  res.writeHead(301, { Location: targetURL });
  res.end();
}).listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT} e redirecionando para: ${targetURL}`);
});
