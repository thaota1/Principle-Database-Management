
import java.awt.*;
import javax.swing.*;



import java.lang.Thread;
import java.awt.event.*;

public class OpeningWindow extends JPanel{
	JFrame window = new JFrame();

    OpeningWindow(){ 
    	//Create Frame

    	window.add(this);
		window.setLocation(250, 150);
		window.setUndecorated(true);
		window.setSize(900, 506);
		window.setVisible(true); 
		
		try {
			Thread.sleep(3000);
			window.dispose();
			login login = new login();
		}catch(Exception e) {System.out.println(e);}

    }
	// Set the Background
	public void paint(Graphics game) {
		ImageIcon background = new ImageIcon("icons//Background.png"); 
		game.drawImage(background.getImage(), 0, 0, null); 
		
	}
    public static void main(String[] arg){
      OpeningWindow f = new OpeningWindow(); 
    	//login f = new login();
    }






}
