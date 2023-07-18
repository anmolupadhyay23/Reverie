const express=require('express');
const userRouter=express.Router();
const auth=require('../middleware/authMiddleware');
const Order = require('../models/order');
const { Product } = require('../models/product');
const User = require('../models/user');

// ADDING PRODUCT TO CART
userRouter.post('/api/add-to-cart',auth, async (req,res)=>{
    try{
        const {id}=req.body;
        const product=await Product.findById(id);
        let user=await User.findById(req.user);
        // Product not in cart
        if(user.cart.length==0){
            user.cart.push({product,quantity: 1})
        }
        else{
            let isProductFound=false;
            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){
                    isProductFound=true;
                }
            }
            // Product in cart
            if(isProductFound) {
                let foundProduct=user.cart.find((foundProduct) => 
                    foundProduct.product._id.equals(product._id)
                );
                foundProduct.quantity+=1;
            }
            else{
                user.cart.push({product, quantity: 1});
            }
        }
        user=await user.save();
        res.json(user);
    } catch(e) {
        res.status(500).json({error: e.message})
    }
});

// DELETING PRODUCT FROM CART
userRouter.delete('/api/remove-from-cart/:id',auth, async (req,res)=>{
    try{
        const {id}=req.params;
        const product=await Product.findById(id);
        let user=await User.findById(req.user);

        for(let i=0;i<user.cart.length;i++){
            if(user.cart[i].product._id.equals(product._id)){
                if(user.cart[i].quantity==1){
                    user.cart.splice(i,1);
                }
                else{
                    user.cart[i].quantity-=1;
                }
            }
        }
        user=await user.save();
        res.json(user);
    } catch(e) {
        res.status(500).json({error: e.message})
    }
});

// SAVE USER ADDRESS
userRouter.post('/api/save-user-address',auth, async (req,res)=>{
    try{
        const {address}=req.body;
        let user=await User.findById(req.user);
        user.address=address;
        user=await user.save();
        res.json(user);
    } catch(e) {
        res.status(500).json({error: e.message})
    }
});

// ORDER PRODUCTS
userRouter.post('/api/order',auth, async (req,res)=>{
    try{
        const {cart, totalPrice, address}=req.body;
        let products=[];
        for(let i=0;i<cart.length;i++){
            let product=await Product.findById(cart[i].product._id);
            if(product.quantity>=cart[i].quantity){
                product.quantity-=cart[i].quantity;
                products.push({product,quantity: cart[i].quantity});
                await product.save();
            }
            else{
                return res.status(400).json({msg: `${product.name} is out of stock`})
            }
        }
        let user=await User.findById(req.user);
        user.cart=[];
        user=await user.save();

        let order=new Order({
            products,
            totalPrice,
            address,
            userId: req.user,
            orderedAt: new Date().getTime(),
        });
        order=await order.save();
        res.json(order);
    } catch(e) {
        res.status(500).json({error: e.message})
    }
});

// SHOW YOUR ORDERS
userRouter.get('/api/orders/me',auth,async (req, res) => {
    try{
        const orders=await Order.find({userId: req.user});
        // console.log(`Order status: ${orders[0].status}`);
        // console.log(`Total Orders: ${orders.length}`);
        let notcompletedOrders=[];
        for(let i=0;i<orders.length;i++){
            if(orders[i].status<3) { // Change it to =3 to delete completed order
                notcompletedOrders.push(orders[i])
                // await Order.findByIdAndDelete(orders[i].id)
            }
        }
        res.json(notcompletedOrders);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

// ADDING PRODUCT TO WISHLIST
userRouter.post('/api/add-to-wishlist',auth, async (req,res)=>{
    try{
        const {id}=req.body;
        const product=await Product.findById(id);
        let user=await User.findById(req.user);
        // Product not in wishlist
        if(user.wishlist.length==0){
            user.wishlist.push({product,quantity: 1})
        }
        else{
            let isProductFound=false;
            for(let i=0;i<user.wishlist.length;i++){
                if(user.wishlist[i].product._id.equals(product._id)){
                    isProductFound=true;
                }
            }
            // Product in wishlist
            if(isProductFound) {
                let foundProduct=user.wishlist.find((foundProduct) => 
                    foundProduct.product._id.equals(product._id)
                );
                foundProduct.quantity+=1;
            }
            else{
                user.wishlist.push({product, quantity: 1});
            }
        }
        user=await user.save();
        res.json(user);
    } catch(e) {
        res.status(500).json({error: e.message})
    }
});

// DELETING PRODUCT FROM WISHLIST
userRouter.delete('/api/remove-from-wishlist/:id',auth, async (req,res)=>{
    try{
        const {id}=req.params;
        const product=await Product.findById(id);
        let user=await User.findById(req.user);

        for(let i=0;i<user.wishlist.length;i++){
            if(user.wishlist[i].product._id.equals(product._id)){
                user.wishlist.splice(i,1);
            }
        }
        user=await user.save();
        res.json(user);
    } catch(e) {
        res.status(500).json({error: e.message})
    }
});

// SHOW YOUR COMPLETED ORDERS
userRouter.get('/api/orders-completed/me',auth,async (req, res) => {
    try{
        const orders=await Order.find({userId: req.user});
        // console.log(`Order status: ${orders[0].status}`);
        // console.log(`Total Orders: ${orders.length}`);
        let completedOrders=[];
        for(let i=0;i<orders.length;i++){
            if(orders[i].status>=3) { // Change it to =3 to delete completed order
                completedOrders.push(orders[i])
                // await Order.findByIdAndDelete(orders[i].id)
            }
        }
        res.json(completedOrders);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

module.exports=userRouter;