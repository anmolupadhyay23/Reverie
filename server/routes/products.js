const express=require("express")
const productRouter=express.Router();
const auth=require('../middleware/authMiddleware')
const {Product}=require('../models/product')

productRouter.get('/api/products',auth,async (req,res) => {
    try{
        const products=await Product.find({
            category: req.query.category
        });
        res.json(products);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

// create a get request to search products and get them
productRouter.get('/api/products/search/:name',auth, async (req,res)=>{
    try{
        const products=await Product.find({
            // regex to match patterns ('i' is used to make regex pattern matching incase sensitive (To search m and M for a search 'm'))
            name: {$regex: req.params.name, $options: "i"},
        });
        res.json(products); // THIS IS THE RETURNING VALUE OF API
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

// create a post request route to rate the product
productRouter.post('/api/rate-product',auth, async (req,res)=>{
    try{
        const {id,rating}=req.body;
        let product=await Product.findById(id);
        for(let i=0;i<product.ratings.length;i++){
            // Find and update Rating 
            if(product.ratings[i].userId==req.user) {
                product.ratings.splice(i,1);
                break;
            }
        }

        const ratingSchema={
            userId: req.user,
            rating
        };

        product.ratings.push(ratingSchema);
        product=await product.save();
        res.json(product);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

// deal of the day (product with highest rating)
productRouter.get('/api/deal-of-the-day',auth,async (req,res) => {
    try{
        let products=await Product.find({});
        products.sort((product_1,product_2)=>{
            let sum_1=0;
            let sum_2=0;
            for(let i=0;i<product_1.ratings.length;i++){
                sum_1+=product_1.ratings[i].rating;
            }
            for(let i=0;i<product_2.ratings.length;i++){
                sum_2+=product_2.ratings[i].rating;
            }

            return sum_1<sum_2 ? 1 : -1;
        });
        return res.json(products[0]);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
})

module.exports=productRouter;