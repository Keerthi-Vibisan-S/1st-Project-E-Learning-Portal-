<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import = "com.admin.*, com.AdminDAO.*, java.util.LinkedList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sharp - Admin</title>

    
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous">
	
    <style>
      .nav-ele-hover:hover, .activate{
        font-size: 1.5rem;
        transition: all 0.3s;
      }
    </style>
  </head>
  <body>
  
  	<%
  	//Preventing back button after logout
  	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  	response.setHeader("Pragma", "no-cache");
  	response.setHeader("Expires", "0");
  	
    if(session.getAttribute("AEmail") == null)
    {
    	response.sendRedirect("AdminLogin.html");
    }
    %>
    
    <header class="navbar navbar-light sticky-top bg-light flex-md-nowrap p-0 shadow">

        <button class="navbar-toggler  d-md-none me-5 collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <a class="navbar-brand px-3" href="#">SHARP</a>
        
        <div class="navbar-nav">
          <div class="nav-item text-nowrap">
            <form action = "AdminLogout" method="post">
            	<button type="submit" class="btn btn-outline-dark">Signout</button>
            </form>
          </div>
        </div>
      </header>
      
      <div class="container-fluid">
        <div class="row">
          <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse bg-dark" style="height: 95vh;">
            <div class="position-sticky pt-3">
              <ul class="nav flex-column">
                <li class="nav-item nav-ele-hover">
                  <a class="text-white nav-link" aria-current="page" href="ADMINHome.jsp">
                    Home
                  </a>
                </li>
                <li class="nav-item nav-ele-hover">
                  <a class="text-white nav-link" href="ADMINStudents.jsp">
                    Student's
                  </a>
                </li>
                <li class="nav-item nav-ele-hover">
                  <a class="text-white nav-link" href="AdminTeachers.jsp">
                    
                    Teacher's
                  </a>
                </li>

                <li class="nav-item nav-ele-hover activate">
                  <a class="text-white nav-link" href="AdminCourses.jsp">    
                    Courses
                  </a>
                </li>

                <li class="nav-item nav-ele-hover">
                  <a class="text-white nav-link" href="AdminStuCourseRegister.jsp">
                    
                    Course Register
                  </a>
                </li>
                
                <li class="nav-item nav-ele-hover">
                  <a class="text-white nav-link" href="AdminStudentCourseVideoSee.jsp">
                    Student's Vseen
                  </a>
                </li>
                
              </ul>
            </div>
          </nav>
      
          <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
              <h1 class="h2">Available Courses</h1>
              <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-group me-2">
                  <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>
                </div>
                <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                  <span data-feather="calendar"></span>
                 
                </button>
              </div>
            </div>
      
            
            <div class="table-responsive card">
              <table class="table table-striped table-sm">
                <thead>
                  <tr>
                    <th scope="col">CId</th>
                    <th scope="col">CName</th>
                    <th scope="col">CPath</th>
                    <th scope="col">Uploader ID</th>
                    <th scope="col">Uploader Email</th>
                    <th scope="col">Status</th>
                    <th scope="col">UDate</th>
                    <th scope="col">Action</th>
                  </tr>
                </thead>
                <tbody>
                <%!
                LinkedList <String> name = new LinkedList <String> ();
            	LinkedList <Integer> Sno = new LinkedList <Integer> ();
            	LinkedList <String> Contact = new LinkedList <String> ();
            	LinkedList <String> Email = new LinkedList <String> ();
            	LinkedList <String> date = new LinkedList <String> ();
            	
            	LinkedList <String> filepath = new LinkedList <String> ();
            	LinkedList <String> status = new LinkedList <String> ();
            	LinkedList <Integer> CourseId = new LinkedList <Integer> ();
            	
            	Integer Sid [] = null;
            	String  Sname [] = null;
            	String SEmail [] = null;
            	String Scontact [] = null;
            	String JDate[] = null;
            	String FilePath[] = null;
            	String Status[] = null;
            	Integer CourseID [] = null;
            	
            	int i = 0;
                %>
                
                <%
                AllStudentInfoCarrier Cfetch = new AllStudentInfoCarrier();
                
                AllUserDAOFetch get = new AllUserDAOFetch();
                boolean flag = get.getAllCourseDetails(Cfetch);
                
                if(flag)
                {
                	Sno = Cfetch.getSno();
                	name = Cfetch.getName();
                	Email = Cfetch.getEmail();
    				filepath = Cfetch.getFilepath();
    				status = Cfetch.getStatus();
    				CourseId = Cfetch.getCourseId();
                	date = Cfetch.getDate();
                	
                	//Converting all LinkedList into Array
                	Sid = Sno.toArray(new Integer[0]);
                	Sname = name.toArray(new String[0]);
                	SEmail = Email.toArray(new String[0]);
					FilePath = filepath.toArray(new String[0]);
                	JDate = date.toArray(new String[0]);
                	CourseID = CourseId.toArray(new Integer[0]);
                	Status = status.toArray(new String[0]);
                	//Length of Array
                	int p = Sid.length;
                	
                	for(i = 0; i<p; i++)
                	{
                
                %>
                
                
                  <tr>
                    <td><%= CourseID[i]%></td>
                    <td><%= Sname[i]%></td>
                    <td><%= FilePath[i]%></td>
                    <td><%= Sid[i]%></td>
                    <td><%= SEmail[i]%></td>
                    <td><%= Status[i]%></td>
                    <td><%= JDate[i]%></td>
                    <td>
                    	<form action = "CourseDelete" method = "post" id="delete-user" onSubmit="return confirm('Are you sure you wish to delete User');">
                    		<input type="text" name="CourseID" value=<%= CourseID[i]%> hidden>
                    		<input type="text" name="UploaderId" value=<%= Sid[i]%> hidden>
                    		<input type="text" name="FilePath" value=<%= FilePath[i]%> hidden>
                    		<button type="submit" class="btn" data-bs-toggle="tooltip" data-bs-placement="bottom" title="DELETE"><i class="fas fa-trash-alt fa-1x text-danger"></i></button>
                    	</form>
                    </td>
                  </tr>
                  
               <%
                	}
                }
               %>
                  
                </tbody>
              </table>
            </div>
          </main>
        </div>
      </div>

    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
  
  </body>
</html>
