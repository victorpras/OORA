package oora.cs194.berkeley.edu;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.TextView;
import android.widget.Toast;




public class OrderActivity extends Activity {
	
	public static Integer numRestaurants = 0;
	String[] rName;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.order);
        /*
    	Parse.initialize(this, "SDPaBFP2RDeggvLdWjPhVHp0RqZGFsS6HezHzH7i", "G2PoJEyOpgAHoj5cFg7GmtHovM33Q8f8BaBAAJFs");
        ParseQuery query = new ParseQuery("Restaurants");
        query.findInBackground(new FindCallback() {
            public void done(List<ParseObject> rList, ParseException e) {
                if (e == null) {
                    //Log.d("score", "Retrieved " + rList.size() + " scores");
                    numRestaurants = rList.size();
                    TextView numPointsText = (TextView) findViewById(R.id.welcome3);
            		numPointsText.setText(Integer.toString(numRestaurants));
            		
            		//System.out.println(rList.get(0));
            		TextView rest1 = (TextView) findViewById(R.id.res1);
            		rest1.setText((rList.get(0)).getString("Name"));  
            		
            		ImageView Image01 = (ImageView) findViewById(R.id.ImageView01);
            		Object content = null;
            		try{
            	      URL url = new URL("http://s3-media4.ak.yelpcdn.com/bphoto/i2ezy6XV-L5EqHbXOWVQTA/l.jpg");
            	      content = url.getContent();
            	    }
            	      catch(Exception ex)
            	    {
            	        ex.printStackTrace();
            	    }
            	    InputStream is = (InputStream)content;
            	    Drawable image = Drawable.createFromStream(is, "src");
            	    Image01.setImageDrawable(image);
            	    Image01.setMaxWidth(75);
            	    Image01.setMaxHeight(100);
            		
            		
            		
            		TextView rest2 = (TextView) findViewById(R.id.res2);
            		rest2.setText((rList.get(1)).getString("Name")); 
            		TextView rest3 = (TextView) findViewById(R.id.res3);
            		rest3.setText((rList.get(2)).getString("Name")); 
            		//rName[0] = (rList.get(0)).getString(rName[0]);
            		//System.out.println(rName[0]);
            		//TextView rest1 = (TextView) findViewById(R.id.res1);
            		//rest1.setText(rName[0]);              
            		
            		
                    
                    //String name = rObj.getString("Name");
                } else {
                    //Log.d("score", "Error: " + e.getMessage());
                }
            }
        });*/
        
        Button store = (Button) findViewById(R.id.backButton);
		store.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						PlaceOrder.class);
				startActivityForResult(myIntent, 0);
			}

		});
		
		
		TextView tv1 = (TextView) findViewById(R.id.res1);
		tv1.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						PastaBene.class);
				startActivityForResult(myIntent, 0);
			}

		});
		
		
		
		TextView tv = (TextView) findViewById(R.id.res2);
		tv.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						RestaurantActivity.class);
				startActivityForResult(myIntent, 0);
			}

		});
		
		TextView tv3 = (TextView) findViewById(R.id.res3);
		tv3.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						StarMeats.class);
				startActivityForResult(myIntent, 0);
			}

		});
		
		TextView tv5 = (TextView) findViewById(R.id.res5);
		tv5.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						MountEverest.class);
				startActivityForResult(myIntent, 0);
			}

		});
		
		TextView tv6 = (TextView) findViewById(R.id.res6);
		tv6.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						WikiWiki.class);
				startActivityForResult(myIntent, 0);
			}

		});
		
		TextView tv7 = (TextView) findViewById(R.id.res7);
		tv7.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						Gregorie.class);
				startActivityForResult(myIntent, 0);
			}

		});
        
		
		
		
    }
    /*
    public void onCheckboxClicked(View v) {
	    // Perform action on clicks, depending on whether it's now checked
	    if (((CheckBox) v).isChecked()) {
	        Toast.makeText(OrderActivity.this, "Selected", Toast.LENGTH_SHORT).show();
	    } else {
	        Toast.makeText(OrderActivity.this, "Not selected", Toast.LENGTH_SHORT).show();
	    }
	}*/
    
}