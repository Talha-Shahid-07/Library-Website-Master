# Library Website Master

A Database Management System (DBMS) project developed for the Database Management System Lab (CEL 222) course at Bahria University Karachi Campus. This system provides a web-based interface for managing library resources, including book searches, reservations, user registration, and account management. It leverages a MySQL database with advanced features like normalization, indexing, views, and stored procedures, integrated with a PHP/HTML/CSS frontend.

## 🌟 Features
- **Database Schema**: Four normalized tables (CategoryTable, UsersTable, BookTable, BookReserve) in Fourth Normal Form (4NF) for efficient data management.
- **User Management**: Secure user registration and login with password hashing and input validation to prevent SQL injection.
- **Book Search**: Flexible search by title, author, or category using a stored procedure, with paginated results.
- **Book Reservation**: Allows users to reserve books and view their reservations.
- **Advanced DBMS Features**:
  - **Indexes**: On BookTitle, Author, Category, and Reserved columns for faster queries.
  - **Views**: Virtual table for simplified book information display.
  - **Stored Procedures**: `SearchBooks` procedure for dynamic book searches.
- **Responsive UI**: Built with HTML, CSS, and JavaScript, ensuring usability on desktop and mobile devices.
- **Security**: Password hashing with PHP’s `password_hash()`, role-based access (planned), and prepared statements.

## 🛠️ Technologies Used
- **Database**: MySQL (normalized to 4NF)
- **Backend**: PHP (for server-side logic and database connectivity)
- **Frontend**: HTML, CSS, JavaScript
- **Tools**:
  - XAMPP (Apache and MySQL server)
  - phpMyAdmin (database management)
  - Visual Studio Code (or similar IDE for development)
- **Dependencies**:
  - PHP 7.4+ with `mysqli` extension
  - MySQL 5.7+
  - Apache server (via XAMPP)

## 🚀 Setup and Installation

### Prerequisites
- **XAMPP**: Install XAMPP to run Apache and MySQL locally.
- **MySQL**: Ensure MySQL is running and accessible via phpMyAdmin.
- **PHP**: Version 7.4 or higher with `mysqli` extension enabled.
- **Browser**: Any modern browser (Chrome, Firefox, etc.) for testing the web interface.

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Talha-Shahid-07/Library-Website-Master.git
   cd Library-Website-Master
   ```
2. **Set Up the Database**:
   - Start XAMPP and ensure Apache and MySQL services are running.
   - Open phpMyAdmin (`http://localhost/phpmyadmin`) and create a database named `lab2`.
   - Import `Database/Database.sql` to create tables, indexes, views, and stored procedures.
3. **Deploy the Application**:
   - Copy the `Source-Code` folder to `C:/xampp/htdocs/` (or your XAMPP `htdocs` directory).
   - Ensure the `Pictures` folder is inside `Source-Code` to load background images.
4. **Update File Paths**:
   - In `Main-Style.css`, update image URLs (e.g., `http://localhost/Source-Code/Pictures/...`) to match your local setup (e.g., `/Source-Code/Pictures/...`).
5. **Run the Application**:
   - Access the website at `http://localhost/Source-Code/Main-Page.html` in your browser.
6. **Test the System**:
   - Register a new user via `Register.php`.
   - Log in via `Login.php` to search for books (`Search.php`) or reserve books (`Reservation.php`).

## 💡 Usage
- **User Registration**: Create an account with a username, password, and contact details. Passwords are hashed for security.
- **Login**: Access your account to view reserved books or perform searches.
- **Search Books**: Use the search form to find books by title, author, or category. Results are paginated (5 items per page).
- **Reserve Books**: Enter an ISBN to reserve a book if available.
- **Logout**: End your session securely via `LoggedOut.php`.
- **Database Management**: Use phpMyAdmin to view or modify the `lab2` database, including tables, views, and stored procedures.

## 📂 Project Structure
```
Library-Website-Master/
├── Database/
│   └── Database.sql              # SQL script for database setup
├── Design-Document/
│   └── [design files]            # ERD and other design documents (.png, .graphml, .md)
├── Source-Code/
│   ├── Pictures/                 # Background images for web pages
│   ├── Main-Page.html            # Homepage
│   ├── Main-Style.css            # CSS styling for all pages
│   └── [other PHP/HTML files]    # Additional pages (e.g., Reserve.php, Unreserve.php)
├── README.md                     # This file
├── LICENSE                       # MIT License
```

## 🤝 Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/YourFeature
   ```
3. Make and commit changes:
   ```bash
   git commit -m 'Add new feature'
   ```
4. Push to the branch:
   ```bash
   git push origin feature/YourFeature
   ```
5. Open a Pull Request on GitHub.

## 📄 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 📧 Contact
For questions or support, please open an issue in the GitHub repository or contact [Your Email].

## Acknowledgments
Developed by Muhammad Usman, Anas, and Talha for the Database Management System Lab (CEL 222) at Bahria University Karachi Campus. Special thanks to our instructor for guidance and support.
