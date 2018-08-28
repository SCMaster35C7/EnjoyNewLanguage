<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
    <head>		
        <title>Your awesome Youtube search engine</title>
        <meta charset="UTF-8" />					
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Awesome videos!" />
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    </head>
    <body>
        <header>
            <h1 class="w100 text-center"><a href="index.html">YouTube Viral Search</a></h1>
        </header>
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <form action="#">
                    <p><input type="text" id="search" placeholder="Type something..." autocomplete="off" class="form-control" /></p>
                    <p><input type="submit" id="sea" value="Search" class="form-control btn btn-primary w100"></p>
                </form>
                <div id="results"></div>
            </div>
        </div>
        
        <!-- scripts -->
        <script type="text/javascript" src="JQuery/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="YoutubeAPI/search.js"></script>
        <script src="https://apis.google.com/js/client.js?onload=init"></script>
        <script>
        	$(function() {
        		$("#sea").on('click', function() {
        			init();
        			search();
        		});
        	});

        </script>
    </body>
</html>