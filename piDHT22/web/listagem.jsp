<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>Listagem de produtos</title>
        <link rel="stylesheet" href="entradaDados.css">
    </head>
    <body>
        <%
            try {
                //Fazer a conexão com o Banco de Dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/sensor", "root", "manape");
                //Listar os dados da tabela leitura do banco de dados 
                st = conecta.prepareStatement("SELECT * FROM leitura");
                ResultSet rs = st.executeQuery();
                %>
                <table>
                   <tr>
                       <th>Código</th>
                       <th>Hora</th>
                       <th>Temperatura</th>
                       <th>Umidade</th>
                       <th>Exclusão</th>
                       <th>Alteração</th>                       
                   </tr>                
                <%
                while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getString("codigo")%></td>
                        <td><%= rs.getString("hora")%></td>
                        <td><%= rs.getString("temperatura")%></td>
                        <td><%= rs.getString("umidade")%></td>
                        <td><a href="excluir.jsp?codigo=<%=rs.getString("codigo")%>">Excluir</a></td>
                        <td><a href="e_carregaRead.jsp?codigo=<%=rs.getString("codigo")%>">Editar</a></td>
                    </tr>
               <%
               }
               %>
               </table>
               <%
        } catch (Exception x) {
            out.print("Mensagem de erro:" + x.getMessage());
        }
    %>   
</body>
</html>
