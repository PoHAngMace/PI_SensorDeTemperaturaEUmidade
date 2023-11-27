<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir leitura</title>
        <link rel="stylesheet" href="entradaDados.css">
    </head>
    <body>
        <%
            // Recebe o código digitado
            int cod;
            cod = Integer.parseInt(request.getParameter("codigo"));
            try {
                //Conecta ao banco de dados chamado banco
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/sensor", "root", "manape");
                // Excluem o produto de código informado
                PreparedStatement st = conecta.prepareStatement("DELETE FROM leitura WHERE codigo=?");
                st.setInt(1, cod);
                int resultado = st.executeUpdate(); // Executa o comando DELETE
                //Verifica se a leitura foi ou  não excluída
                if (resultado == 0) {
                    out.print("Esta leitura não está cadastrada");
                } else {
                    out.print("A leitura de código " + cod + " foi excluída com sucesso");
                }
            } catch (Exception erro) {
                String mensagemErro = erro.getMessage();
                out.print("Entre em contato com o suporte e informe o erro " + mensagemErro);
            }
        %>   
    </body>
</html>
