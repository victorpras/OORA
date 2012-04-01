package oora.cs194.berkeley.edu;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import com.parse.Parse;
import com.parse.ParseObject;
import com.parse.ParseException;
import com.parse.ParseQuery;

public class OrderActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.order);
        
    	Parse.initialize(this, "tVEZrlbL1zIiWjje6ZhE9DM5wNf7DKbMLm9hbZeP", "vKsuZD2X8oTkHHVLWTcFYS0hCF03cSVh1ocM0Y3u");
        ParseQuery query = new ParseQuery("Restaurants");
        ParseObject gameScore;
        try {
            gameScore = query.get("xWMyZ4YEGZ");
        } catch (ParseException e) {
            // e.getMessage() will have information on the error.
        }
        
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