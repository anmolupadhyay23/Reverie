const express=require('express');
const adminRoute=express.Router();
const admin=require('../middleware/adminMiddleware');
const {Product} = require('../models/product');
const Order=require('../models/order')

// ADDING PRODUCT
adminRoute.post('/admin/add-product',admin, async (req,res)=>{
    try{
        const {name,description,images,quantity,price,category} = req.body;
        let product=new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });
        product=await product.save();
        res.json(product)
    } catch(e) {
        res.status(500).json({error: e.message})
    }
});

// FETCH PRODUCTS
adminRoute.get('/admin/get-products',admin,async (req,res)=>{
    try{
        const products=await Product.find({});
        res.json(products);
    } catch(e) {
        res.status(500).json({error:e.message});
    }
});

// DELETE PRODUCT
adminRoute.post('/admin/delete-product',admin,async (req,res)=>{
    try{
        const {id}=req.body;
        let product=await Product.findByIdAndDelete(id);
        res.json(product);
    } catch(e) {
        res.status(500).json({error: e.message})
    }
});

// FETCH ORDERS
adminRoute.get('/admin/get-orders',admin,async (req,res)=>{
    try{
        const orders=await Order.find({});
        res.json(orders);
    } catch(e) {
        res.status(500).json({error:e.message});
    }
});

// CHANGE ORDER STATUS
adminRoute.post('/admin/change-order-status',admin,async (req,res)=>{
    try{
        const {id,status}=req.body;
        let order=await Order.findById(id);
        order.status=status;

        // DELETING THE ORDER FROM DATABASE WILL LEAD TO DELETING IT FOR THE USER ALSO
        if(order.status==4){
            // WE CAN MAKE NEW COLLECTION FOR COMPLETED ORDER AND FETCH IT ON A NEW PAGE
            // await Order.findByIdAndDelete(id);
            console.log('Order Completed Successfully')
        }
        else{
            order=await order.save();
            res.json(order);
        }
    } catch(e) {
        res.status(500).json({error: e.message})
    }
});

module.exports=adminRoute;