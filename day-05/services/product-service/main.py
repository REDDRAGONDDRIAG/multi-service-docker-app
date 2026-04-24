from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import os
from dotenv import load_dotenv
import logging

load_dotenv()

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="Product Service",
    version="1.0.0"
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mock database
products_db = [
    {"id": 1, "name": "DevOps Course", "price": 99.99, "stock": 100},
    {"id": 2, "name": "Docker Guide", "price": 49.99, "stock": 50},
    {"id": 3, "name": "K8s Mastery", "price": 79.99, "stock": 75},
]

# Routes
@app.get("/")
def root():
    return {"service": "product-service", "version": "1.0"}

@app.get("/health")
def health():
    return {"status": "healthy", "service": "product-service"}

@app.get("/products")
def list_products(skip: int = 0, limit: int = 10):
    return {
        "products": products_db[skip:skip+limit],
        "total": len(products_db)
    }

@app.get("/products/{product_id}")
def get_product(product_id: int):
    for product in products_db:
        if product["id"] == product_id:
            return product
    return {"error": "Product not found"}, 404

@app.post("/products")
def create_product(name: str, price: float, stock: int = 0):
    product = {
        "id": len(products_db) + 1,
        "name": name,
        "price": price,
        "stock": stock
    }
    products_db.append(product)
    return product

if __name__ == "__main__":
    import uvicorn
    port = int(os.getenv("PORT", 3002))
    uvicorn.run("main:app", host="0.0.0.0", port=port, reload=True)
