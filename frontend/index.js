import { backend } from "declarations/backend";

let cart = [];
let phones = [];

async function loadPhones() {
    try {
        document.getElementById('loading').style.display = 'flex';
        phones = await backend.getAllPhones();
        filterPhones('all');
    } catch (error) {
        console.error("Error loading phones:", error);
    } finally {
        document.getElementById('loading').style.display = 'none';
    }
}

function filterPhones(filter) {
    let filteredPhones = phones;
    
    if (filter === 'modern') {
        filteredPhones = phones.filter(phone => phone.price > 500);
    } else if (filter === 'classic') {
        filteredPhones = phones.filter(phone => phone.price <= 500);
    }
    
    displayPhones(filteredPhones);
    updateActiveFilter(filter);
}

function updateActiveFilter(filter) {
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.classList.remove('active');
        if (btn.dataset.filter === filter) {
            btn.classList.add('active');
        }
    });
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
                <p class="specs">${phone.specs}</p>
                <p class="storage">${phone.storage} • ${phone.color}</p>
                <p class="price">$${phone.price}</p>
                <button onclick="addToCart(${JSON.stringify(phone).replace(/"/g, '&quot;')})">Add to Cart</button>
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
    cartIcon.style.transform = 'scale(1.2)';
    setTimeout(() => {
        cartIcon.style.transform = 'scale(1)';
    }, 200);
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
            <span>${item.name}</span>
            <div>
                <span>$${item.price}</span>
                <button onclick="removeFromCart(${index})" style="width: auto; margin-left: 10px; padding: 5px 10px;">Remove</button>
            </div>
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
document.querySelectorAll('.filter-btn').forEach(btn => {
    btn.addEventListener('click', () => filterPhones(btn.dataset.filter));
});

document.addEventListener('DOMContentLoaded', loadPhones);
