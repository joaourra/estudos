<html>
	
	<head>
		<title>Site em php</title>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous">
		</script>
		<style type="text/css">
			.linha {
				color: red;
				
			}
		</style>
		<link rel="stylesheet" href="style.css">
	</head>
	
	<body>
		<header>
			<img src="foto.png" alt="alt sem foto">
			<h1 id="title">Titulo no cabeçalho</h1>
		</header>
		<section>
			<header>
				<h2 class="subtitle">Cabeçalho da seção</h2>
			</header>
			<article>
				<header class="post_title">Cabeçalho do post</header>
				<?php
			for ($i = 1 ; $i <= 10 ; $i++){
				print("<span class=\"linha\">Linha feita com javascript " . $i . "</span><br/>");
			}
				?>
			
			</article>
	
		</section>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			alert("Woohoo popup");
		})
	</script>
	
</html>