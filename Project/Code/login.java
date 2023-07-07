
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import java.sql.*;

public class login implements ActionListener{


    login(){
    	//Create Frame
    	JFrame window = new JFrame("International University - VNU HCMC"); 
    	window.setVisible(true);
    	window.setSize(600,300);
    	window.setLocation(400,300);
    	window.setBackground(Color.LIGHT_GRAY);
    	window.setLayout(null); 
    	
    	//Login Image
        JLabel loginimage = new JLabel();
        loginimage.setBounds(20,30,350,150);
        loginimage.setLayout(null);
        ImageIcon i1 = new ImageIcon("icons/login.png");
        loginimage.setIcon(i1);
        window.add(loginimage);
       
        //Login title
    	JLabel login = new JLabel("LOGIN");
    	login.setBounds(250,10,100,20);
    	login.setFont(new Font("serif",Font.PLAIN,22));
    	login.setForeground(Color.BLUE);
        window.add(login); 

    	//Account zone
    	JLabel acc = new JLabel("Account");
    	acc.setBounds(140,40,100,30);
        window.add(acc);
        JTextField acctext = new JTextField();
        acctext.setBounds(230,40,190,30);
        window.add(acctext);
        
        //Password zone
        JLabel pass = new JLabel("Password");
        pass.setBounds(140,110,100,30);
        window.add(pass);
        JPasswordField passtext = new JPasswordField();
        passtext.setBounds(230,110,190,30);
        window.add(passtext);
        
         //Login and Exit Button
        JButton loginbutton = new JButton("Login");
        loginbutton.setBounds(160,180,100,30);
        loginbutton.setFont(new Font("serif",Font.PLAIN,17));
        loginbutton.addActionListener(this);
        loginbutton.setBackground(Color.BLUE);
        loginbutton.setForeground(Color.WHITE);
        window.add(loginbutton);

        JButton exitbutton =new JButton("Exit");
        exitbutton.setBounds(300,180,100,30);
        exitbutton.setFont(new Font("serif",Font.PLAIN,17));
        exitbutton.addActionListener(this);
        exitbutton.setBackground(Color.BLUE);
        exitbutton.setForeground(Color.WHITE);
        window.add(exitbutton);

        //Set background for Pane
        window.getContentPane().setBackground(Color.WHITE);

        //Set animation for Login
        while(true){
            login.setVisible(false); 
            loginimage.setVisible(false);
            try{
                Thread.sleep(1000); 
            }catch(Exception e){} 
            login.setVisible(true); 
            loginimage.setVisible(true);
            try{
                Thread.sleep(1000);
            }catch(Exception e){}
        }
    }




	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		
	}
}
