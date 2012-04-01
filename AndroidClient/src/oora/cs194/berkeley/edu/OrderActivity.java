package oora.cs194.berkeley.edu;

import java.util.List;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import com.parse.Parse;
import com.parse.ParseObject;
import com.parse.ParseException;
import com.parse.ParseQuery;
import com.parse.FindCallback;

public class OrderActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.order);
        
    	Parse.initialize(this, "SDPaBFP2RDeggvLdWjPhVHp0RqZGFsS6HezHzH7i", "G2PoJEyOpgAHoj5cFg7GmtHovM33Q8f8BaBAAJFs");
        ParseQuery query = new ParseQuery("Restaurants");
        query.findInBackground(new FindCallback() {
            public void done(List<ParseObject> rList, ParseException e) {
                if (e == null) {
                    //Log.d("score", "Retrieved " + rList.size() + " scores");
                    //String name = rObj.getString("Name");
                } else {
                    //Log.d("score", "Error: " + e.getMessage());
                }
            }
        });
        
        Button store = (Button) findViewById(R.id.backButton);
		store.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						OORAActivity.class);
				startActivityForResult(myIntent, 0);
			}

		});
        
        
    }
}