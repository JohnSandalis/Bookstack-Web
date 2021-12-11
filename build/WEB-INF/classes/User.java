/**
 * POJO of users table
 * @author Giorgos Lagoudakis
 * @version 1.0
 */
public class User {

    private final int id;
    private final String email;
    private final String password;
    private final int credits;
    private final int booksGiven;
    private final int booksTaken;
    private final String username;
    private final String fullName;
    private final String address;
    private final String country;
    private final String postalCode;
    private final int atFloor;
    private final String region;
    private final String city;
    private final String lang;

    public User(int id, String email, String password, int credits, int booksGiven, int booksTaken, String username,
                String fullName, String address, String country, String postalCode, int atFloor, String region,
                String city, String lang) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.credits = credits;
        this.booksGiven = booksGiven;
        this.booksTaken = booksTaken;
        this.username = username;
        this.fullName = fullName;
        this.address = address;
        this.country = country;
        this.postalCode = postalCode;
        this.atFloor = atFloor;
        this.region = region;
        this.city = city;
        this.lang = lang;
    }

    public int getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public int getCredits() {
        return credits;
    }

    public int getBooksGiven() {
        return booksGiven;
    }

    public int getBooksTaken() {
        return booksTaken;
    }

    public String getUsername() {
        return username;
    }

    public String getFullName() {
        return fullName;
    }

    public String getAddress() {
        return address;
    }

    public String getCountry() {
        return country;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public int getAtFloor() {
        return atFloor;
    }

    public String getRegion() {
        return region;
    }

    public String getCity() {
        return city;
    }

    public String getLang() {
        return lang;
    }
}
