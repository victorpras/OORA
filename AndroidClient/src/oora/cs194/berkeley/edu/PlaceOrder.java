package oora.cs194.berkeley.edu;

import java.util.List;

import android.app.Activity;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import com.parse.FindCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;




public class PlaceOrder extends Activity {
	
	public static Integer numRestaurants = 0;
	String[] rName;
	
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        
        ScrollView sv = new ScrollView(this);
        LinearLayout ll  = new LinearLayout(this);
        ll.setOrientation(LinearLayout.VERTICAL);
        sv.addView(ll);
        
        TextView tv = new TextView(this);
        tv.setText("Restaurant List");
        ll.addView(tv);
        
        
        Parse.initialize(this, "SDPaBFP2RDeggvLdWjPhVHp0RqZGFsS6HezHzH7i", "G2PoJEyOpgAHoj5cFg7GmtHovM33Q8f8BaBAAJFs");
        ParseQuery query = new ParseQuery("Restaurants");
        query.findInBackground(new FindCallback() {
            public void done(List<ParseObject> rList, ParseException e) {
                if (e == null) {
                    
                    numRestaurants = rList.size();
                    
                    for(int i = 0; i < 6; i++) {
                    	rName[i] = (rList.get(i)).getString("Name");
                    }
                    
                } else {
                     
                }
            }
        });
         
        /*for (int i = 0; i < 6; i++) {
        	TextView tv1 = new TextView(this);
        	tv1.setText(rName[i]);
        	ll.addView(tv1);
        	
        }*/
        
        this.setContentView(sv);
    }
    
    
    
}