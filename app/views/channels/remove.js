$("#li-user-<%=@user.id%>").animate({height:'0px'}, 500)
setTimeout(
  function() 
  {
    $("#user-<%=@user.id%>").remove()
  }, 5000);
