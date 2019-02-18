package net;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JTextField;

public class CClientGUI extends JFrame{
	private JTextField textToSend;
	private JTextArea conversation;
	private JButton quitButton;
	private JButton sendButton;
	
	
	public CClientGUI() {
		super();
		buildGUI();
		addListeners();
	}
	
	private void buildGUI() {
		getContentPane().setLayout(new BorderLayout());
		textToSend = new JTextField(10);
		conversation = new JTextArea();
		quitButton = new JButton("Quit");
		sendButton = new JButton("Send");
		JPanel panel = new JPanel();
		panel.add(quitButton);
		panel.add(sendButton);
		getContentPane().add(textToSend, BorderLayout.NORTH);
		getContentPane().add(conversation, BorderLayout.CENTER);
		getContentPane().add(panel, BorderLayout.SOUTH);
		setSize(200, 400);
		setVisible(true);
	}
	
	private void addListeners() {
		quitButton.addActionListener(new ActionListener() {
			@Override
		    public void actionPerformed(ActionEvent e)
		    {
		    	dispose();
		    }
		});
		sendButton.addActionListener(new ActionListener() {
			@Override
		    public void actionPerformed(ActionEvent e)
		    {
		    	try {
		    		System.out.println(textToSend.getText().toString());
					CClient.getInstance().sendMessage(textToSend.getText().toString());
				} catch (IOException e1) {
					e1.printStackTrace();
				}
		    }
		});
		
	}
	
	
}
