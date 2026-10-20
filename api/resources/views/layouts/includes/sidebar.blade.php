<nav class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h5 class="mb-0">
            <i class="bi bi-speedometer2"></i> Admin
        </h5>
        <button class="btn-close btn-close-white d-lg-none" id="sidebarToggle"></button>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link {{ request()->is('dashboard') ? 'active' : '' }}" href="{{ route('dashboard') }}">
                <i class="bi bi-house-door"></i> Dashboard
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-toggle="collapse" href="#usersMenu">
                <i class="bi bi-people"></i> Users <i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <div class="collapse {{ request()->is('users*') ? 'show' : '' }}" id="usersMenu">
                <ul class="nav flex-column ms-3">
                    <li><a class="nav-link" href="#">View Users</a></li>
                    <li><a class="nav-link" href="#">Add User</a></li>
                </ul>
            </div>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-toggle="collapse" href="#productsMenu">
                <i class="bi bi-box"></i> Products <i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <div class="collapse {{ request()->is('products*') ? 'show' : '' }}" id="productsMenu">
                <ul class="nav flex-column ms-3">
                    <li><a class="nav-link" href="#">View Products</a></li>
                    <li><a class="nav-link" href="#">Add Product</a></li>
                </ul>
            </div>
        </li>

        <li class="nav-item">
            <a class="nav-link {{ request()->is('settings') ? 'active' : '' }}" href="#">
                <i class="bi bi-gear"></i> Settings
            </a>
        </li>
    </ul>
</nav>
