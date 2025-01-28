<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>News Results | By PurgyXsh</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background: #000;
            position: relative;
            overflow-x: hidden;
            color: #fff;
        }

        .bg-img {
            background-image: url('bg.gif');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            width: 100%;
            height: 100vh;
            position: fixed;
            z-index: -1;
        }

        /* Navigation Button */
        .nav-button {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 100;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background: rgba(0, 102, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .nav-button:hover {
            background: rgba(0, 102, 255, 0.4);
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(0, 195, 255, 0.3);
        }

        .nav-button .arrow {
            font-size: 20px;
            transition: transform 0.3s ease;
        }

        .nav-button:hover .arrow {
            transform: translateX(-5px);
        }

        .container {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            padding-top: 80px; /* Added to account for fixed nav button */
        }

        .results-header {
            color: #fff;
            font-size: 35px;
            margin-bottom: 2rem;
            text-shadow: 2px 2px 4px rgb(0, 132, 255);
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
            padding-bottom: 1rem;
        }

        .results-list {
            list-style: none;
        }

        .article-card {
            background: rgba(0, 0, 0, 0.7);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .article-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 102, 255, 0.2);
        }

        .article-title {
            color: #fff;
            font-size: 24px;
            margin-bottom: 1rem;
            text-shadow: 1px 1px 2px rgb(0, 132, 255);
        }

        .article-description {
            color: #ccc;
            margin-bottom: 1rem;
            line-height: 1.6;
        }

        .read-more {
            display: inline-block;
            padding: 8px 20px;
            background: #0066ff;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .read-more:hover {
            background: #0052cc;
            transform: scale(1.05);
        }

        .back-button {
            display: inline-block;
            padding: 12px 30px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            transition: all 0.3s ease;
            margin-top: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .back-button:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: scale(1.05);
        }

        .no-results {
            text-align: center;
            padding: 3rem;
            background: rgba(0, 0, 0, 0.7);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
                padding-top: 80px;
            }

            .results-header {
                font-size: 28px;
            }

            .article-title {
                font-size: 20px;
            }

            .article-card {
                padding: 1rem;
            }

            .nav-button {
                padding: 10px 20px;
                font-size: 14px;
            }
        }

        @media (max-width: 480px) {
            .results-header {
                font-size: 24px;
            }

            .article-title {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
    <div class="bg-img"></div>
    <a href="index.html" class="nav-button">
        <span class="arrow">←</span>
        <span>Back to Search</span>
    </a>
    <div class="container">
        <h1 class="results-header">Results for "<span id="searchKeyword"></span>"</h1>
        <ul class="results-list" id="articlesList"></ul>
        <div class="no-results" id="noResults" style="display: none;">
            <h2>No results found</h2>
            <p>Try searching with different keywords</p>
        </div>
    </div>

    <script>
        const API_KEY = '0942f566ede14770bbfbff129e5c5bff';
        
        async function fetchNews() {
            const keyword = sessionStorage.getItem('searchKeyword');
            if (!keyword) {
                window.location.href = 'index.html';
                return;
            }

            document.getElementById('searchKeyword').textContent = keyword;

            try {
                const response = await fetch(`https://newsapi.org/v2/everything?q=${encodeURIComponent(keyword)}&apiKey=${API_KEY}`);
                const data = await response.json();

                if (data.articles && data.articles.length > 0) {
                    displayArticles(data.articles);
                } else {
                    showNoResults();
                }
            } catch (error) {
                console.error('Error fetching news:', error);
                showNoResults();
            }
        }

        function displayArticles(articles) {
            const articlesList = document.getElementById('articlesList');
            articlesList.innerHTML = '';

            articles.forEach(article => {
                const li = document.createElement('li');
                li.className = 'article-card';
                li.innerHTML = `
                    <h3 class="article-title">${article.title}</h3>
                    <p class="article-description">${article.description || 'No description available'}</p>
                    <a href="${article.url}" target="_blank" class="read-more">Read more</a>
                `;
                articlesList.appendChild(li);
            });

            document.getElementById('noResults').style.display = 'none';
            articlesList.style.display = 'block';
        }

        function showNoResults() {
            document.getElementById('articlesList').style.display = 'none';
            document.getElementById('noResults').style.display = 'block';
        }

        // Fetch news when the page loads
        document.addEventListener('DOMContentLoaded', fetchNews);
    </script>
</body>
</html>