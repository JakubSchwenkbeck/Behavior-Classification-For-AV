function visualizePredicition(predict)
        
        
    Win = struct();
    Win.Fig = uifigure("Name","Prediction", ...
        "Position",[200,200,300,300] );

    Win.MainGrid = uigridlayout(Win.Fig,[4 4]);

    Win.MainButton = uibutton(Win.MainGrid,"Text","Start",'ButtonPushedFcn', @buttonCallback);
    Win.MainButton.Layout.Row = 1;
    Win.MainButton.Layout.Column = [1 2];
    
   
   

    Win.Panel = uipanel(Win.MainGrid);
     Win.Panel.Layout.Row = [2 4];
     Win.Panel.Layout.Column = [1 4];

     Win.Label = uilabel(Win.MainGrid,"Text","-Value-");
     Win.Label.Layout.Row = 1;
      Win.Label.Layout.Column = 4;
     
    

     Win.Panel.BackgroundColor = "#FAEBD7";
    
    
% Callback
    function buttonCallback(src, event)
        changePanel(1,predict,Win)
    end
end

 

function changePanel(index,predict,Win)
        value = predict(index);
        disp("ime here")

   
        % green (0) -> yellow (0.5) -> red (1)
        r = min(1, 2*value);
        g = min(1, 2*(1-value));
        b = 0;
        
        Win.Label.Text = num2str(value);
        Win.Panel.BackgroundColor = [r, g, b];
        
      
        pause(0.2);
         disp("here")
[~,sz] =  size(predict);
        if(index+1 <=sz)
          
        changePanel(index+1,predict,Win);
        end
    end