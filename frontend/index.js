import { backend } from "declarations/backend";

let cart = [];
let phones = [];

async function loadPhones() {
    try {
        document.getElementById('loading').style.display = 'flex';
        phones = await backend.getAllPhones();
        displayPhones(phones);
    } catch (error) {
        console.error("Error loading phones:", error);
    } finally {
        document.getElementById('loading').style.display = 'none';
    }
}

function displayPhones(phones) {
    const container = document.getElementById('phones-container');
    container.innerHTML = '';

    phones.forEach(phone => {
        const phoneElement = document.createElement('div');
        phoneElement.className = 'phone-card';
        phoneElement.innerHTML = `
            <img src="${phone.imageUrl}" alt="${phone.name}" class="phone-image">
            <div class="phone-info">
                <h3>${phone.name}</h3>
                <p class="brand">${phone.brand}</p>
                <p class="description">${phone.description}</p>
                <p class="price">$${phone.price}</p>
                <button onclick="addToCart(${JSON.stringify(phone).replace(/"/g, '&quot;')})">ADD TO CART</button>
            </div>
        `;
        container.appendChild(phoneElement);
    });
}

window.addToCart = function(phone) {
    cart.push(phone);
    updateCartCount();
    showAddedAnimation();
};

function updateCartCount() {
    document.getElementById('cart-count').textContent = cart.length;
}

function showAddedAnimation() {
    const cartIcon = document.querySelector('.cart-icon');
    cartIcon.classList.add('bounce');
    setTimeout(() => cartIcon.classList.remove('bounce'), 500);
}

window.showCart = function() {
    const modal = document.getElementById('cart-modal');
    const cartItems = document.getElementById('cart-items');
    const cartTotal = document.getElementById('cart-total');
    
    cartItems.innerHTML = '';
    let total = 0;

    cart.forEach((item, index) => {
        total += item.price;
        const itemElement = document.createElement('div');
        itemElement.className = 'cart-item';
        itemElement.innerHTML = `
            <span>${item.name} - $${item.price}</span>
            <button onclick="removeFromCart(${index})">Remove</button>
        `;
        cartItems.appendChild(itemElement);
    });

    cartTotal.textContent = total;
    modal.style.display = 'flex';
};

window.closeCart = function() {
    document.getElementById('cart-modal').style.display = 'none';
};

window.removeFromCart = function(index) {
    cart.splice(index, 1);
    updateCartCount();
    showCart();
};

document.querySelector('.cart-icon').addEventListener('click', showCart);

// Load phones when page loads
document.addEventListener('DOMContentLoaded', loadPhones);
