$("#li-user-<%=@user.id%>").animate({height:'0px'}, 500)
$(".ul-user").animate({height:'-=60px'}, 500);
setTimeout(
  function() 
  {
    $("li-user-#user-<%=@user.id%>").remove()
  }, 1000);
