<!--Web Development 2 Assignment-->
<!--Author: Gabriel Grimberg.-->
<!--Website: Library Website-->
<!--Page: Search-->

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="Main-Style.css"/>
    <title>Search</title>
</head>
<body>
    <div class="header">
        <div class="container">
            <div id="menu">
                <ul class="nav">
                    <li><a href="Main-Page.html">Welcome</a></li>
                    <li><a href="Search.php">Search</a></li>
                    <li><a href="Reservation.php">Reserve</a></li>
                    <li><a href="Register.php">Register</a></li>
                    <li><a href="Login.php">My Account</a></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="backgroundfix6">
        <div class="container">  
            <div class="main">
                <h1>Search</h1>
                <p class="btn-primary">Search for a book in the library, you may wish to reserve it if available.</p>
            </div>
        </div>
    </div>

    <br>
    <div class="Form2">
        <h1 class="loginheader">Search For A Book</h1>
        <p>Fill in one or more options to search for a book.</p>
        
        <form action="SearchResults.php" method="GET">
            Title of Book:<br><input type="text" name="TitleOfBook">
            <br><br>
            Author of Book:<br><input type="text" name="AuthorOfBook">
            <br><br>
            Category of Book:<br>
            <?php
                require('DatabaseConnect.php');
                $Query = $Connection->query("SELECT CategoryID, CategoryDescription FROM CategoryTable");
                echo "<select name='CategoryOfBook'>";
                echo '<option value="">Select a category</option>';
                while ($Row = $Query->fetch_assoc()) {
                    $CategoryIDVar = $Row['CategoryID'];
                    $SelectOptionName = $Row['CategoryDescription'];
                    echo '<option value="' . $CategoryIDVar . '">' . htmlspecialchars($SelectOptionName) . '</option>';
                }
                echo "</select><br><br>";
            ?>
            <input type="submit" value="Submit">
        </form>
    </div>

    <br><br>
    <div class="clearfix"></div>
    <div class="footer">
        <div class="container">
            <p>Copyright. 2016 All rights reserved.</p>
        </div>
    </div>
</body>
</html>