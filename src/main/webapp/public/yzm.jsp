<%@ page contentType="image/jpeg"  language="java" import="java.awt.image.*,javax.imageio.*,java.io.*,java.awt.*,java.util.*" errorPage="" %>
<%!
  Color getRandColor(int fc,int bc){
    Random random=new Random();
    if (fc >255) fc=255;
    if (bc >255) bc=255;
    int r=fc+random.nextInt(bc-fc);
    int g=fc+random.nextInt(bc-fc);
    int b=fc+random.nextInt(bc-fc);
    return new Color(r,g,b);
  } 
%>
<%
try{
	  response.setHeader("Pragma", "no-Cache");
	  response.setHeader("Cache-Control", "no-Cache");
	  response.setDateHeader("Expires", 0);
	  int width=80;
	  int height=30;
	  BufferedImage image=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
	  OutputStream os=response.getOutputStream(); 
	  Graphics g=image.getGraphics();
	  Random random=new Random();
	   g.setColor(Color.black);
	  //g.setColor(new Color(164,180,212));
	  g.drawRect(0,0,width-1,height-1);
	  g.setColor(getRandColor(200,250));
	  g.fillRect(0,0,width,height);
	  g.setColor(getRandColor(160,200));
	  g.setFont(new Font("Arial Black", Font.PLAIN, 18));
	  for (int i=0;i<155;i++)
	  {
	     int x=random.nextInt(width);
	     int y=random.nextInt(height);
	     int xl=random.nextInt(12);
	     int yl=random.nextInt(12);
	     g.drawLine(x,y, xl, yl);
	  }
	  String str="ABCDEFGHJKMLNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
	  //g.setFont(new Font("Arial Black", Font.PLAIN, 15));
	  String sjs="";
	  for(int i=0;i<4;i++){
	    int a=random.nextInt(str.length()-1);
	    String s=str.substring(a,a+1);
	    sjs+=s;
	    g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
	    g.drawString(s,15*i+8,20);
	  };
	  g.dispose();
	  session.setAttribute("yzm", sjs);
	  ImageIO.write(image,"jpeg",os);
	  os.flush();
	  os.close();  
	  os=null;  
	  response.flushBuffer();  
	  out.clear();  
	  out = pageContext.pushBody();  
  }  
  catch(IllegalStateException e)  
  {  
	  System.out.println(e.getMessage());  
	  e.printStackTrace();  
  }
%>
