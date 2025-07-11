<!--Web Development 2 Assignment-->
<!--Author: Gabriel Grimberg.-->
<!--Website: Library Website-->
<!--Page: Search Continued-->

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="Main-Style.css"/>
    <title>Search Results</title>
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
                <h1>Results Of Your Search</h1>
                <p class="btn-primary">Here are the results for your search...</p>
            </div>
        </div>
    </div>

    <?php
    require('DatabaseConnect.php');

    // Initialize pagination
    $pageNumber = isset($_GET['PageNumber']) ? max(0, (int)$_GET['PageNumber']) : 0;
    $itemsPerPage = 5;
    $offset = $pageNumber * $itemsPerPage;

    // Get and sanitize input
    $title = isset($_GET['TitleOfBook']) && !empty(trim($_GET['TitleOfBook'])) ? trim($_GET['TitleOfBook']) : null;
    $author = isset($_GET['AuthorOfBook']) && !empty(trim($_GET['AuthorOfBook'])) ? trim($_GET['AuthorOfBook']) : null;
    $category = isset($_GET['CategoryOfBook']) && !empty(trim($_GET['CategoryOfBook'])) ? (int)$_GET['CategoryOfBook'] : null;

    // Validate input: at least one field must be provided
    if (!$title && !$author && !$category) {
        echo "<br>";
        echo "<div class='Form2'><h2>You must enter at least one search criterion.</h2></div>";
        echo "<br>";
        echo "<div class='Form'><h3><a href='Search.php'>Try again</a></h3></div>";
        echo "<div class='clearfix'></div>";
        echo "<div class='footer'>";
        echo "<div class='container'>";
        echo "<p>Copyright. 2016 All rights reserved.</p>";
        echo "</div>";
        echo "</div>";
        exit;
    }

    // Prepare the stored procedure call
    $stmt = $Connection->prepare("CALL SearchBooks(?, ?, ?)");
    $stmt->bind_param("ssi", $title, $author, $category);
    $stmt->execute();
    $result = $stmt->get_result();

    // Fetch all results to handle pagination manually
    $allRows = [];
    while ($row = $result->fetch_assoc()) {
        $allRows[] = $row;
    }
    $stmt->close();

    // Apply pagination
    $totalRows = count($allRows);
    $pagedRows = array_slice($allRows, $offset, $itemsPerPage);

    // Display current page number
    echo "<div class='Form2'>";
    echo "<h2>Page " . ($pageNumber + 1) . "</h2>";
    echo "</div>";

    // Display results
    if (empty($pagedRows)) {
        echo "<br>";
        echo "<div class='Form2'><h2>No books found.</h2></div>";
        echo "<br>";
        echo "<div class='Form'><h3><a href='Search.php'>Try again</a></h3></div>";
    } else {
        echo "<table border='2' align='center' width='600'>";
        foreach ($pagedRows as $row) {
            echo "<tr>";
            echo "<td>";
            echo "<div class='Form2'>";
            echo '<br /> ISBN: ' . htmlspecialchars($row['ISBN']);
            echo '<br /> Book Title: ' . htmlspecialchars($row['BookTitle']);
            echo '<br /> Author: ' . htmlspecialchars($row['Author']);
            echo '<br /> Edition: ' . htmlspecialchars($row['Edition']);
            echo '<br /> Reserved: ' . ($row['Reserved'] ? 'Yes' : 'No');
            echo '<br /><br />';
            echo "</div>";
            echo "</td>";
            echo "</tr>";
        }
        echo "</table>";
    }

    // Pagination links
    $vars = http_build_query([
        'TitleOfBook' => $title,
        'AuthorOfBook' => $author,
        'CategoryOfBook' => $category
    ]);
    echo "<br><br>";
    if ($pageNumber > 0) {
        echo "<div class='Form2'><h3><a href='SearchResults.php?PageNumber=" . ($pageNumber - 1) . "&$vars'>Previous Page</a></h3></div>";
    }
    if ($offset + $itemsPerPage < $totalRows) {
        echo "<div class='Form2'><h3><a href='SearchResults.php?PageNumber=" . ($pageNumber + 1) . "&$vars'>Next Page</a></h3></div>";
    }
    ?>

    <br><br>
    <div class="clearfix"></div>
    <div class="footer">
        <div class="container">
            <p>Copyright. 2016 All rights reserved.</p>
        </div>
    </div>
</body>
</html>