# Booknest
### A book lending library

Welcome to the **Booknest**, a Ruby on Rails application that allows users to sign up, log in, and borrow books. Each book has details such as a title, description, author, availability status, and a unique ISBN number.

## Features
- **User Authentication**: Secure signups and logins using Rails 8 authentication.
- **Book Management**: View books with details like title, description, author, and availability status.
- **Borrowing System**: Users can check if a book is available and borrow it.
- **Database**: Uses SQLite (Rails 8 default).

## Installation and Setup

Follow these steps to get the application running locally:

### Prerequisites
Make sure you have the following installed:
- Ruby (latest compatible version with Rails 8)
- Rails 8
- Bundler
- SQLite3

### Steps to Run the Application
1. **Clone the repository**
   ```sh
   git clone https://github.com/ndegwa007/Booknest.git
   cd Booknest
   ```

2. **Install dependencies**
   ```sh
   bundle install
   ```

3. **Set up the database**
   ```sh
   rails db:migrate
   rails db:seed  # Seeds the database with book data
   ```

4. **Start the Rails server**
   ```sh
   rails server
   ```

5. **Access the application**
   Open your browser and go to: `http://localhost:3000`

6. **Running tests**
   ``` rspec ```

## Usage
- **Sign up or log in** to access the library.
- Browse the available books.
- Check book availability.
- Borrow books and return them when done.

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

## License
This project is open-source and available under the [MIT License](LICENSE).

## Contact
For any issues or suggestions, feel free to open an issue or reach out to [Martin Ndegwa](mailto:ndegwa8781@gmail.com).
