const http = require("http")
const server = http.createServer();
const {Server} = require("socket.io")
const io = new Server(server)

const PORT = process.env.PORT || 3700;

 io.on("connection", (socket) => {
     socket.io("position-change", (data) => {
         conosle.log("Opalac: "+data)
         io.emit("position-change", data);
     });

     socket.on("disconnect", () => {

     });
 }); 

 server.listen(PORT, () => {
     console.log(`listening on ${PORT}`);
 })