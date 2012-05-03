package oora.cs194.berkeley.edu;

import java.io.InputStream;
import java.net.URL;

import android.app.Activity;
import android.app.AlertDialog;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;

import com.parse.Parse;


public class RestaurantActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	
    	Parse.initialize(this, "tVEZrlbL1zIiWjje6ZhE9DM5wNf7DKbMLm9hbZeP", "vKsuZD2X8oTkHHVLWTcFYS0hCF03cSVh1ocM0Y3u");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.restaurant);
        
        ImageView Image01 = (ImageView) findViewById(R.id.image1);
		Object content = null;
		try{
	      URL url = new URL("http://s3-media3.ak.yelpcdn.com/bphoto/DLEIVrNV5JhPZRTbmn3s1Q/l.jpg");
	      content = url.getContent();
	    }
	      catch(Exception ex)
	    {
	        ex.printStackTrace();
	    }
		
		
		
	    InputStream is = (InputStream)content;
	    Drawable image = Drawable.createFromStream(is, "src");
	    Image01.setImageDrawable(image);
	  
	    
	    ImageView Image02 = (ImageView) findViewById(R.id.image2);
		Object content2 = null;
		try{
	      URL url = new URL("http://s3-media1.ak.yelpcdn.com/bphoto/wWPqMf3w1YMK9l7aB4kwzw/l.jpg");
	      content2 = url.getContent();
	    }
	      catch(Exception ex)
	    {
	        ex.printStackTrace();
	    }
	    InputStream ist = (InputStream)content2;
	    Drawable image2 = Drawable.createFromStream(ist, "src");
	    Image02.setImageDrawable(image2);
	    Image02.setMaxWidth(50);
	    Image02.setMaxHeight(5);
        
	    Button button1 = (Button) findViewById(R.id.button1);
	    
	    
	    button1.setOnClickListener(new View.OnClickListener() {
			public void onClick(View v) {
				// TODO Auto-generated method stub
				int price = 0;
				EditText edit3 = (EditText) findViewById(R.id.edit3);
			    EditText edit4 = (EditText) findViewById(R.id.edit4);
			   // String burrito = edit3.getText().toString(); 
			   // int burritoI = Integer.parseInt(burrito);
			    price = price + (Integer.valueOf(edit3.getText().toString()) * 6);
			    price = price + (Integer.parseInt(edit4.getText().toString()) * 2);
		        
		        final String total = Integer.toString(price);
				AlertDialog.Builder builder = new AlertDialog.Builder(
						RestaurantActivity.this);
				builder.setTitle("Confirm Your Order");
				builder.setMessage("The total will be " + total);
				builder.setPositiveButton("OK", null);
				
				builder.setCancelable(true);
				builder.create().show();
			}
		});
	    
	    
    }
}