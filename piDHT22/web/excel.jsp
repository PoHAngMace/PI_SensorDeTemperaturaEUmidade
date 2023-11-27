<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.FileReader" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro via Excel</title>
        <link rel="stylesheet" href="entradaDados.css">
    </head>
    <body>
        <%
            String sql = "";
            PreparedStatement st;
            try {
                //Conecta ao banco de dados chamado banco
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/sensor", "root", "manape");
                //Ler o arquivo Excel
                FileReader arquivo = new FileReader("C:\\Users\\manap\\P_Coisa\\exemplo01.txt"); //endereço do arquivo do Excel
                BufferedReader br = new BufferedReader(arquivo);
                String linha;
                //Se a linha lida do arquivo produtos.csv não estiver nula
                while ((linha = br.readLine()) != null) {
                    //Pegam os valores da linha do arquivo excel e joga em variáveis
                    String[] dados = linha.split(",");
                    //limpa o valor contido em dados[0] de caracteres ocultos
                    String cod = dados[0].replaceAll("[^0-9]", "");
                    int c = Integer.parseInt(cod);
                    String h = String.valueOf(dados[1]);
                    double t = Double.parseDouble(dados[2]);
                    double u = Double.parseDouble(dados[3]);
                    //Busca pelo produto antes de inserir na tabela
                    sql = "SELECT * FROM leitura WHERE codigo = ?";
                    st = conecta.prepareStatement(sql);
                    st.setInt(1, c);
                    ResultSet resultado = st.executeQuery(); //Executa o select
                    if (!resultado.next()) { //se não encontrou o produto na tabela                    
                        //Prepara o comando insert para inserir os dados na tabela
                        sql = "INSERT INTO leitura VALUES(?,?,?,?)";
                        st = conecta.prepareStatement(sql);
                        st.setInt(1, c);
                        st.setString(2, h);
                        st.setDouble(3, t);
                        st.setDouble(4, u);
                        st.executeUpdate(); //Executa o comando insert
                        out.print("A leitura <b>" + c + "</b> foi cadastrada com sucesso <br>");
                    } else {
                        out.print("A leitura <b>" + c + "</b> já está cadatrada <br>");
                    }
                }
                br.close();
            } catch (Exception erro) {
                out.print("Entre em contato com o suporte e informe o erro: " + erro.getMessage());
            }
        %>    
    </body>
</html>
