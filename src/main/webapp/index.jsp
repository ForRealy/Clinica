<%
  Usuario user = (Usuario) session.getAttribute("usuario");
  if(user!=null){
%>
  <h1>Bienvenido, <%=user.getUsername()%></h1>
  <ul>
    <li><a href="odontologos">Odontólogos</a></li>
    <li><a href="pacientes">Pacientes</a></li>
    <li><a href="visitas">Visitas</a></li>
    <% if(user.getRol()==Usuario.Rol.ADMIN){ %>
      <li><a href="usuarios">Usuarios</a></li>
    <% } %>
  </ul>
<% } %>
