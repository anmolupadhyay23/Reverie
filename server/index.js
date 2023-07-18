const express=require("express");
const mongoose=require("mongoose");
const adminRoute = require("./routes/admin");

const authRouter=require("./routes/auth");
const productRouter = require("./routes/products");
const userRouter = require("./routes/user");

const PORT=3000;
const app=express();

// MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRoute);
app.use(productRouter);
app.use(userRouter);

mongoose
    .connect('mongodb+srv://riverie:JIVA06081923@cluster0.payw0ix.mongodb.net/?retryWrites=true&w=majority')
    .then(()=>{
    console.log('connection to database succesful')
}).catch((e)=>{
    console.log(e);
})

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at port ${PORT}`)
});