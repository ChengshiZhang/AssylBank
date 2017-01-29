%IMPORTANT: When you press the "all" button to withdraw all your money, it might 
%take a few seconds to process the image. It' not an empty figure window!

% a GUI -- entire function is based on GUI
% a data base: a vector of structures  -- Bankdata.dat
% reading from at least one data file (into your data structure)   -- line 122, 212 269, 332, 398, 461, 538, 628, 691, 752
% at least one anonymous function   -- line 730
% at least one function that has a variable number of input and/or output arguments  -- line 749
% plotting  -- line 725
% sorting your data base  -- line 718
% indexing on at least one field in your data base  -- the member variable is the index
% some statistical analysis on your data base  -- line 730
% image processing -- the getTwenty, getFourty, getHundred, getTwoHundred, getAll functions

function AssylBank()
   %Creating the main figure window
   f = figure('Visible','off','Units','normalized','Position',[0.1 0.1 0.8 0.8],'Color','w','Name','A$$YL BANK');
   movegui(f,'center');
   fid = fopen('Bankdata.dat');
   numMember = 0;
   while ~feof(fid)
       numMember = numMember+1; 
       wwelcome1 = fgetl(fid);             
   end
   b = fclose(fid);
   if b ~= 0
       disp('File close not successful')
   end
   member = 1;      
   title = '';
   n = '';
   n2 = '';
   nfirst = '';
   nlast = '';
   Balance = 0.00;
   minv= 0;
   maxv= 10000.00;
   % Welcome textbox
   wwelcome1 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.1 0.55 0.8 0.4],'BackgroundColor','w','ForegroundColor','r','String','Welcome to A$$YL Bank!','FontSize',55);  
   % New customer pushbutton 
   wwelcome2 = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.3 0.5 0.4 0.2],'BackgroundColor','w','ForegroundColor','k','String','New Customer','FontSize',30,'Callback',@newCustomer);
   % Returning customer pushbutton
   wwelcome3 = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.3 0.2 0.4 0.2],'BackgroundColor','w','ForegroundColor','k','String','Returning Customer','FontSize',30,'Callback',@oldCustomer);
   % Instructions textboxes
   wtitle = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.1 0.5 0.8 0.2],'BackgroundColor','w','ForegroundColor','b','String','Please select your title','FontSize',40);
   wentername = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.1 0.5 0.8 0.2],'BackgroundColor','w','ForegroundColor','b','String','Please enter your first and last name','FontSize',40);
   % Texboxes with different titles
   wmr = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.15 0.2 0.2 0.2],'BackgroundColor','w','ForegroundColor','k','String','Mr.','FontSize',30,'Callback',@mr);
   wmrs = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.425 0.2 0.2 0.2],'BackgroundColor','w','ForegroundColor','k','String','Mrs.','FontSize',30,'Callback',@mrs);
   wms = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.7 0.2 0.2 0.2],'BackgroundColor','w','ForegroundColor','k','String','Ms.','FontSize',30,'Callback',@ms);
   % Editable text box to enter a new customer's name
   wname = uicontrol('Style','edit','Visible','off','Units','normalized','Position',[0.2 0.4 0.6 0.2],'BackgroundColor','w','ForegroundColor','k','FontSize',30,'Callback',@name);
   % Editable text box to enter a returning customer's name
   wname2 = uicontrol('Style','edit','Visible','off','Units','normalized','Position',[0.2 0.4 0.6 0.2],'BackgroundColor','w','ForegroundColor','k','FontSize',30,'Callback',@check);
   % Text box with instructions for the initial balance
   wbalance1 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.1 0.5 0.8 0.2],'BackgroundColor','w','ForegroundColor','b','String','Please select your initial balance','FontSize',40);
   % Slider for selecting the initial balance
   wbalance2 = uicontrol('Style','slider','Visible','off','Units','normalized','Position',[0.1 0.2 0.75 0.2],'Min',minv,'Max',maxv,'Callback',@dispBalance);
   %text boxes to show the min and max values
   minval= uicontrol('Style','text','Visible','off','BackgroundColor','white','Units','normalized','Position',[0.05 0.2 0.05 0.2],'String',num2str(minv));
   maxval= uicontrol('Style','text','Visible','off','Background','white','Units','normalized','Position',[0.85 0.2 0.08 0.2],'String',num2str(maxv));
   %text box to show current value
   btext= uicontrol('Style','text','Visible','off','BackgroundColor','white','Units','normalized','Position',[0.05 0.1 0.8 0.2]);
   %Next pushbutton
   wdispBalance = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.7 0.1 0.2 0.2],'BackgroundColor','w','ForegroundColor','k','String','Next','FontSize',30,'Callback',@main);
   wmain2 = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.6 0.5 0.3 0.18],'BackgroundColor','w','ForegroundColor','k','String','Withdraw','FontSize',30,'Callback',@withdraw);
   wmain3 = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.6 0.3 0.3 0.18],'BackgroundColor','w','ForegroundColor','k','String','Deposit','FontSize',30,'Callback',@deposit);
   % Current balance text box
   wmain4 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.03 0.5 0.4 0.2],'BackgroundColor','w','ForegroundColor','b','String','Current Balance:','FontSize',40);
   % Stats pushbutton
   wmain6 = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.6 0.1 0.3 0.18],'BackgroundColor','w','ForegroundColor','k','String','Stats','FontSize',30,'Callback',@stats);
   % Select amount textbox 
   wwithdraw1 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.5 0.6 0.5 0.2],'BackgroundColor','w','ForegroundColor',[0.4 0.4 0.3],'String','Select Amount','FontSize',55);
   % Pushbuttons for different sums of money available to withdraw
   w20= uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.53 0.45 0.2 0.15],'BackgroundColor','w','ForegroundColor','k','String','$20','FontSize',30,'Callback',@getTwenty);
   w40= uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.53 0.28 0.2 0.15],'BackgroundColor','w','ForegroundColor','k','String','$40','FontSize',30,'Callback',@getFourty);
   w100= uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.75 0.45 0.2 0.15],'BackgroundColor','w','ForegroundColor','k','String','$100','FontSize',30,'Callback',@getHundred);
   w200= uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.75 0.28 0.2 0.15],'BackgroundColor','w','ForegroundColor','k','String','$200','FontSize',30,'Callback',@getTwoHundred);
   wall= uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.53 0.1 0.42 0.15],'BackgroundColor','w','ForegroundColor','k','String','All','FontSize',30,'Callback',@getAll);
   % Back pushbuttons returns the user to the main menu
   wback = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.15 0.05 0.2 0.12],'BackgroundColor','w','ForegroundColor','k','String','Back','FontSize',30,'Callback',@main);
   % Textbox containing the instructions to display the transactions
   wstats1 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.1 0.3 0.8 0.5],'BackgroundColor','w','ForegroundColor','r','String',sprintf('Please enter the number of past transactions you want to check or press enter to show all'),'FontSize',50);
   % Editable textbox for the user to enter the # of transactions the user
   % would like to see
   wstats2 = uicontrol('Style','edit','Visible','off','Units','normalized','Position',[0.35 0.2 0.3 0.2],'BackgroundColor','w','ForegroundColor','k','FontSize',30,'Callback',@dispStats);
   % Go to the main menu pushbutton
   mainbutton = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.6 0.1 0.4 0.2],'BackgroundColor','w','ForegroundColor','k','String','Go to main menu','FontSize',20,'Callback',@main);
   % Additional instructions for the stats
   wstats3 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.1 0.3 0.8 0.5],'BackgroundColor','w','ForegroundColor','b','String',sprintf('Enter 0 if you want the data sorted in ascending order'),'FontSize',40);
   % Displaying the first figure the user sees
   set([f,wwelcome1,wwelcome2,wwelcome3],'Visible','on')


    %transfer user from welcome screen to select title screen
    function newCustomer(hObject,eventdata)
        set([wwelcome2,wwelcome3],'Visible','off')
        set([wtitle,wmr,wmrs,wms],'Visible','on')
    end
    %transfer user from welcome screen to enter name screen(registered user)
   function  oldCustomer(h0bject,eventdata)
        set([wwelcome2,wwelcome3],'Visible','off')
        set([wentername,wname2],'Visible','on') 
   end
    %pop "error" figure window when the name is not found in data file, or
    %transfer to welcome registered user screen
    function check(h0bject,eventdata)
       
        n2 = get(wname2,'String');
        [nfirst, nlast] = strtok(n2);
       
        fid=fopen('Bankdata.dat');
       if fid == -1 
           disp('File open not successful')
       else
            member = 1;
  
           data = cell(1,numMember+1);
       
       i=1;
        while feof(fid) == 0
            data{i} = fgetl(fid);
           i=i+1;
        end
        
           while (isempty(strfind(data{member},n2))) && (member <= numMember)
            member = member+1;
           end
           
           if member > numMember 
            f3000=figure('Visible','off','Units','normalized','Position',[0.7 0.5 0.29 0.4],'Color','w','Name','A$$YL BANK');
               wmain6 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.15 0.3 0.5 0.4],'BackgroundColor','w','ForegroundColor','r','String','Sorry, name not found','FontSize',40);
            set([wmain6,f3000],'Visible','on')
          
           else
               set([wentername,wname2],'Visible','off')
                 profile = data{member};
               [title, rest1] = strtok(profile);
                [nfirst, rest2] = strtok(strtrim(rest1)); 
                [nlast, rest3] = strtok(strtrim(rest2));
                [Balance, ~] = strtok(strtrim(rest3)); 
                Balance = str2num(Balance);
               wmain6 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.2 0.4 0.6 0.3],'BackgroundColor','w','ForegroundColor','b','String',sprintf('Welcome back, %s%s!',title,nlast),'FontSize',45);
               mainbutton = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.6 0.1 0.4 0.2],'BackgroundColor','w','ForegroundColor','k','String','Go to main menu','FontSize',40,'Callback',@main);
               
                
                set([wmain6,mainbutton],'Visible','on')
               
               
           end
           close=fclose(fid);
           if close ~= 0
               disp('Close not successful')
           end
       end
    end

    %assign "Mr." to the variable "title", transfer to new user name screen
    function mr(hObject,eventdata)
        set([wmr,wmrs,wms,wtitle],'Visible','off')        
        title = 'Mr.';
        set([wentername,wname],'Visible','on')
    end
    
    %assign "Mrs." to the variable "title", transfer to new user name screen
    function mrs(hObject,eventdata)
        set([wmr,wmrs,wms,wtitle],'Visible','off')   
        title = 'Mrs.';
        set([wentername,wname],'Visible','on')
    end

    %assign "Ms." to the variable "title", transfer to new user name screen
    function ms(hObject,eventdata)
        set([wmr,wmrs,wms,wtitle],'Visible','off')
        title = 'Ms.';
        set([wentername,wname],'Visible','on')
    end

    %assign user's first and last name to the variables "nfirst" and "nlast",
    %transfer to new user balance screen
    function name(hObject,eventdata)
        set([wentername,wname],'Visible','off')
        n = get(wname,'String');
        [nfirst, nlast] = strtok(n);
        set([wbalance1,wbalance2,minval,maxval],'Visible','on')
        
    end 
    %assign user's balance to the variable "Balance", show the button that
    %transfers user to main menu
    function dispBalance(hObject,eventdata)
        b1=get(wbalance2,'Value');
        set(btext,'Visible','on','String',num2str(b1),'FontSize',25)
        Balance = uint32(get(wbalance2,'Value'));
        fid = fopen('Bankdata.dat','a');
        fprintf(fid,'\n%s %s%s %s %s',title,nfirst,nlast,num2str(Balance),num2str(Balance));
        closeresult = fclose(fid);
        if closeresult~=0
            disp('File close not successful')
        end
        numMember = numMember +1;
        set(wdispBalance,'Visible','on')
    end
    
    % assign user's index to the variable member, show welcome sentence,
    % display current balance, show three buttons: "withdraw", "deposit",
    % "stats"
    function main(hObject,eventdata)
        set([wbalance1,wbalance2,wwelcome1,wdispBalance,btext,minval,maxval,wmain6,mainbutton,wwithdraw1,w20,w40,w100,w200,wall,wback],'Visible','off')
        
        fid = fopen('Bankdata.dat');
        %take the file into a cell array named data
        data = cell(1,numMember+1);
        for i = 1: numMember
         data{i} = fgetl(fid);
        end
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end
        
        member = 1;
        nlast = strtrim(nlast);
        fprintf('%s%s',nfirst,nlast)
        
        while isempty(strfind(data{member},sprintf('%s %s',nfirst,nlast)))&& (member <= numMember)
              member = member+1;
        end
        

        if isempty(Balance)
        Balance = uint32(get(wbalance2,'Value'));
        end
        
        b = uicontrol('Style','text','Visible','off','Units','normalized','Position',[-0.23 0.6 0.8 0.4],'BackgroundColor','w','ForegroundColor','r','String','A$$YL Bank','FontSize',40);
        wmain1 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.02 0.7 0.5 0.2],'BackgroundColor','w','ForegroundColor','b','String',sprintf('Grettings, %s%s!',title,nlast),'FontSize',40);
        wmain5 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.1 0.3 0.4 0.2],'BackgroundColor','w','ForegroundColor','b','String',sprintf('$%s',num2str(Balance)),'FontSize',40);
        wmain2 = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.6 0.5 0.3 0.18],'BackgroundColor','w','ForegroundColor','k','String','Withdraw','FontSize',30,'Callback',@withdraw);
        wmain3 = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.6 0.3 0.3 0.18],'BackgroundColor','w','ForegroundColor','k','String','Deposit','FontSize',30,'Callback',@deposit);
        wmain4 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.03 0.5 0.4 0.2],'BackgroundColor','w','ForegroundColor','b','String','Current Balance:','FontSize',40);
        wmain6 = uicontrol('Style','pushbutton','Visible','off','Units','normalized','Position',[0.6 0.1 0.3 0.18],'BackgroundColor','w','ForegroundColor','k','String','Stats','FontSize',30,'Callback',@stats);
        set([b,wmain1,wmain2,wmain3,wmain4,wmain5,wmain6],'Visible','on')
        
    end
    
    %transfer user to withdraw screen
    function withdraw(hObject,eventdata)
        set([wmain2,wmain3,wmain6],'Visible','off')
        set([wwithdraw1,w20,w40,w100,w200,wall,wback],'Visible','on')
    end
     
    % pop "error" figure window if the balance is below $20, rewrite data
    % file: change corresponding balance value, add the new balance to the
    % corresponding profile data as new transaction, display image of $20
    % in a new figure window
    function getTwenty(hObject,eventdata)
        pic20 = imread('20.jpg');
        
        if Balance <20 
        f2 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.4 0.3],'Color','w','Name','A$$YL BANK'); 
        movegui(f2,'center')
        wwelcome1 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.2 0.8 0.8],'BackgroundColor','w','ForegroundColor','r','String','Not enough money!!!','FontSize',65);  
        else
        
        
        %to change the balance and transaction record in the 'Bankdata.dat' file   
        fid = fopen('Bankdata.dat');

        data = cell(1,numMember);
        for i = 1: numMember
           data{i} = fgetl(fid);
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end 

        profile = data{member};
        [title, rest1] = strtok(profile);
        [nfirst, rest2] = strtok(strtrim(rest1)); 
        [nlast, rest3] = strtok(strtrim(rest2));
        [~, Trans] = strtok(strtrim(rest3)); 
        
     
        Balance = Balance-20;
        data{member} = sprintf('%s %s %s %s %s %s %s',title,nfirst,nlast,num2str(Balance),strtrim(Trans),num2str(Balance));
        fid = fopen('Bankdata.dat','w');

        fprintf(fid,'%s',data{1});
        for i = 2: numMember
           fprintf(fid,'\n%s',data{i});
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end  
        
        
        
        wmain5 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.3 0.4 0.2],'BackgroundColor','w','ForegroundColor','b','String',sprintf('$%s',num2str(Balance)),'FontSize',40);
        
        f2 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.4 0.3],'Color','w','Name','A$$YL BANK'); 
        movegui(f2,'center')
        image(pic20)
        axis('image')
        axis off
        
        end
    end

    % pop "error" figure window if the balance is below $40, rewrite data
    % file: change corresponding balance value, add the new balance to the
    % corresponding profile data as new transaction, display two images of $20
    % in a new figure window
    function getFourty(hObject,eventdata)
        pic20 = imread('20.jpg');
        
        if Balance <40 
        f2 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.4 0.3],'Color','w','Name','A$$YL BANK'); 
        movegui(f2,'center')
        wwelcome1 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.2 0.8 0.8],'BackgroundColor','w','ForegroundColor','r','String','Not enough money!!!','FontSize',65);  
        else
        
        
        %to change the balance and transaction record in the 'Bankdata.dat' file   
        fid = fopen('Bankdata.dat');

        data = cell(1,numMember);
        for i = 1: numMember
           data{i} = fgetl(fid);
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end   
        
        profile = data{member};
        [title, rest1] = strtok(profile);
        [nfirst, rest2] = strtok(strtrim(rest1)); 
        [nlast, rest3] = strtok(strtrim(rest2));
        [~, Trans] = strtok(strtrim(rest3)); 

 
        Balance = Balance-40;
        data{member} = sprintf('%s %s %s %s %s %s %s',title,nfirst,nlast,num2str(Balance),strtrim(Trans),num2str(Balance));
        fid = fopen('Bankdata.dat','w');

        fprintf(fid,'%s',data{1});
        for i = 2: numMember
           fprintf(fid,'\n%s',data{i});
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end  
        
        
        
        wmain5 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.3 0.4 0.2],'BackgroundColor','w','ForegroundColor','b','String',sprintf('$%s',num2str(Balance)),'FontSize',40);
        
        f2 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.4 0.6],'Color','w','Name','A$$YL BANK'); 
        movegui(f2,'center')
        subplot(2,1,1)
        image(pic20)
        axis('image')
        axis off
        subplot(2,1,2)
        image(pic20)
        axis('image')
        axis off
        end
    end

    % pop "error" figure window if the balance is below $100, rewrite data
    % file: change corresponding balance value, add the new balance to the
    % corresponding profile data as new transaction, display image of $100
    % in a new figure window
    function getHundred(hObject,eventdata)
        pic100 = imread('100.jpg');
        if Balance <100 
        f2 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.4 0.3],'Color','w','Name','A$$YL BANK'); 
        movegui(f2,'center')
        wwelcome1 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.2 0.8 0.8],'BackgroundColor','w','ForegroundColor','r','String','Not enough money!!!','FontSize',65);  
        else
        
        
        %to change the balance and transaction record in the 'Bankdata.dat' file   
        fid = fopen('Bankdata.dat');

        data = cell(1,numMember);
        for i = 1: numMember
           data{i} = fgetl(fid);
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end   
        
        profile = data{member};
        [title, rest1] = strtok(profile);
        [nfirst, rest2] = strtok(strtrim(rest1)); 
        [nlast, rest3] = strtok(strtrim(rest2));
        [~, Trans] = strtok(strtrim(rest3)); 

        
        Balance = Balance-100;
        data{member} = sprintf('%s %s %s %s %s %s %s',title,nfirst,nlast,num2str(Balance),strtrim(Trans),num2str(Balance));
        fid = fopen('Bankdata.dat','w');

        fprintf(fid,'%s',data{1});
        for i = 2: numMember
           fprintf(fid,'\n%s',data{i});
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end  
        
        
        
        wmain5 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.3 0.4 0.2],'BackgroundColor','w','ForegroundColor','b','String',sprintf('$%s',num2str(Balance)),'FontSize',40);
        
        f2 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.4 0.3],'Color','w','Name','A$$YL BANK'); 
        movegui(f2,'center')
        image(pic100)
        axis('image')
        axis off
        
        end
           
    end

    % pop "error" figure window if the balance is below $200, rewrite data
    % file: change corresponding balance value, add the new balance to the
    % corresponding profile data as new transaction, display two images of $100
    % in a new figure window
    function getTwoHundred(hObject,eventdata)
        pic100=imread('100.jpg');
        if Balance <200 
        f2 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.4 0.3],'Color','w','Name','A$$YL BANK'); 
        movegui(f2,'center')
        wwelcome1 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.2 0.8 0.8],'BackgroundColor','w','ForegroundColor','r','String','Not enough money!!!','FontSize',65);  
        else
        
        
        %to change the balance and transaction record in the 'Bankdata.dat' file   
        fid = fopen('Bankdata.dat');

        data = cell(1,numMember);
        for i = 1: numMember
           data{i} = fgetl(fid);
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end   
        
        profile = data{member};
        [title, rest1] = strtok(profile);
        [nfirst, rest2] = strtok(strtrim(rest1)); 
        [nlast, rest3] = strtok(strtrim(rest2));
        [~, Trans] = strtok(strtrim(rest3)); 

        
        Balance = Balance-200;
        data{member} = sprintf('%s %s %s %s %s %s %s',title,nfirst,nlast,num2str(Balance),strtrim(Trans),num2str(Balance));
        fid = fopen('Bankdata.dat','w');

        fprintf(fid,'%s',data{1});
        for i = 2: numMember
           fprintf(fid,'\n%s',data{i});
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end  
        
        
        
        wmain5 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.3 0.4 0.2],'BackgroundColor','w','ForegroundColor','b','String',sprintf('$%s',num2str(Balance)),'FontSize',40);
        
        f2 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.4 0.6],'Color','w','Name','A$$YL BANK'); 
        movegui(f2,'center')
        subplot(2,1,1)
        image(pic100)
        axis('image')
        axis off
        subplot(2,1,2)
        image(pic100)
        axis('image')
        axis off
        end
    end 

    % pop "error" figure window if the balance is below $20, rewrite data
    % file: change corresponding balance value, add the new balance to the
    % corresponding profile data as new transaction, display required number 
    % of images of $20 and $100 in a new figure window
    function getAll(hObject,eventdata)
   
        pic100=imread('100.jpg');
        pic20 = imread('20.jpg');
        if Balance <=20 
        f2 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.6 0.3],'Color','w','Name','A$$YL BANK');  
        movegui(f2,'center')
        wwelcome1 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.2 0.8 0.8],'BackgroundColor','w','ForegroundColor','r','String','Not enough money!!!','FontSize',65);  
        else
        num100s = (double(Balance)/100);
        num100s = fix(num100s);
        num20s = (double(Balance)-100*double(num100s))/20;
        num20s = fix(num20s);
        if num20s>=5
            num100s = num100s+1;
            num20s = num20s-5;
        end
        
        
        
         %to change the balance and transaction record in the 'Bankdata.dat' file   
        fid = fopen('Bankdata.dat');

        data = cell(1,numMember);
        for i = 1: numMember
           data{i} = fgetl(fid);
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end   
        
        profile = data{member};
        [title, rest1] = strtok(profile);
        [nfirst, rest2] = strtok(strtrim(rest1)); 
        [nlast, rest3] = strtok(strtrim(rest2));
        [~, Trans] = strtok(strtrim(rest3)); 

        
        Balance = double(Balance)-double(num100s)*100-double(num20s)*20;
        data{member} = sprintf('%s %s %s %s %s %s %s',title,nfirst,nlast,num2str(Balance),strtrim(Trans),num2str(Balance));
        fid = fopen('Bankdata.dat','w');

        fprintf(fid,'%s',data{1});
        for i = 2: numMember
           fprintf(fid,'\n%s',data{i});
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end  
        
        
        wmain5 = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.3 0.4 0.2],'BackgroundColor','w','ForegroundColor','b','String',sprintf('$%s',num2str(Balance)),'FontSize',40);        
        
        
        
        f2 = figure('Visible','on','Units','normalized','Position',[0.02 0.02 0.96 0.96],'Color','w','Name','A$$YL BANK');  
        movegui(f2,'center')
        
        sidecount = 1;
        while (sidecount^2)<num100s
            sidecount = sidecount+1;
        end
        
      
        
        
        for i = 1:num100s
        subplot(double(sidecount),double(sidecount),double(i))
        image(pic100)
        axis('image')
        axis off
        end
        if num20s ~=0
        f3 = figure('Visible','on','Units','normalized','Position',[0.05 0 0.9 0.2],'Color','w','Name','A$$YL BANK');
        for i = 1:num20s
            subplot(1,double(num20s),double(i))
            image(pic20)
            axis('image')
            axis off
        end
        end
        
       
        
        end
    end
           
    %pop new figure window and prompt user for the amount of money to
    %deposit, rewrite the file: change corresponding balance value, add 
    %the new balance to the corresponding profile data as new transaction
    function deposit(hObject,eventdata)
        f4 = figure('Visible','on','Units','normalized','Position',[0.0 0.7 0.4 0.6],'Color','w','Name','A$$YL BANK');  
        movegui(f4,'center')
       %set([wbalance1,wbalance2,a,wdispBalance,btext,minval,maxval,b,wmain1,wmain2,wmain3,wmain4,wmain5],'Visible','off')
       deptext=uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.25 0.6 0.5 0.1],'String','Enter the amount','ForegroundColor','g','FontSize',30);
        huitext= uicontrol('Style','edit','Units','normalized','Position',[0.45 0.4 0.1 0.1],'Callback',@enterdeposit);
        set(deptext,'Visible','on')
        %displaying user's input
        function enterdeposit(h0nject,eventdata)
            set([deptext,huitext],'Visible','off');
            figure(1)
            depositv=get(huitext,'String');
            Balance=Balance+str2double(depositv);
            
            %to change the balance and transaction record in the 'Bankdata.dat' file   
        fid = fopen('Bankdata.dat');

        data = cell(1,numMember);
        for i = 1: numMember
           data{i} = fgetl(fid);
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end   
        
        profile = data{member};
        [title, rest1] = strtok(profile);
        [nfirst, rest2] = strtok(strtrim(rest1)); 
        [nlast, rest3] = strtok(strtrim(rest2));
        [~, Trans] = strtok(strtrim(rest3)); 

        
        data{member} = sprintf('%s %s %s %s %s %s %s',title,nfirst,nlast,num2str(Balance),strtrim(Trans),num2str(Balance));
        fid = fopen('Bankdata.dat','w');

        fprintf(fid,'%s',data{1});
        for i = 2: numMember
           fprintf(fid,'\n%s',data{i});
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end  
            
            hstr=uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.3 0.4 0.2],'BackgroundColor','w','ForegroundColor','b','String',sprintf('$%s',num2str(Balance)),'FontSize',40);
            set(hstr,'Visible','on')
            set(f4,'Visible','off')
        end 
    end


        % pop new figure window and display instructions for displaying
        % statistics of corresponding user's transactions:
        % empty displays all transactions, 0 displays all transactions in
        % ascending order, and integers to display specific numbers of
        % transactions, error check if the number is invalid
        function stats(hObject,eventdata)
              fstats = figure('Visible','on','Units','normalized','Position',[0.1 0.1 0.7 0.9],'Color','w','Name','A$$YL BANK');
              movegui(fstats,'center')
              wstats1 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.1 0.6 0.8 0.3],'BackgroundColor','w','ForegroundColor','b','String',sprintf('Please enter the number of past transactions you want to check or press enter to show all'),'FontSize',50);
              wstats2 = uicontrol('Style','edit','Visible','off','Units','normalized','Position',[0.4 0.2 0.2 0.2],'BackgroundColor','w','ForegroundColor','k','FontSize',30,'Callback',@dispStats);
              wstats3 = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.1 0.54 0.8 0.1],'BackgroundColor','w','ForegroundColor','b','String',sprintf('Enter 0 if you want the data sorted in ascending order'),'FontSize',30);
              set([wstats1,wstats2,wstats3],'Visible','on')
        end
        
        %displays graph of wanted statistics of transactions, displays
        %statistic calculations of the transaction data on the lower half
        %of the screen
        function dispStats(hObject,eventdata)
             
              
              numTrans = get(wstats2,'String');
              
              fid = fopen('Bankdata.dat');

             data = cell(1,numMember);
             for i = 1: numMember
                 data{i} = fgetl(fid);
             end
        
        
             b = fclose(fid);
              if b~=0
                 disp('File close not successful')
              end  
        
              profile = data{member};
              [title, rest1] = strtok(profile);
              [nfirst, rest2] = strtok(strtrim(rest1)); 
              [nlast, rest3] = strtok(strtrim(rest2));
              [~, Trans] = strtok(strtrim(rest3));
                 vec = str2num(strtrim(Trans));
                 
              
              if (isempty(numTrans))||((str2num(numTrans)<=length(vec))&&(str2num(numTrans)>=0))
                  
                  
                  
                  set([wstats1,wstats2,wstats3],'Visible','off')
              if isempty(numTrans)
                  vecTrans = getData(member);
              elseif numTrans == '0'
                  vecTrans = sort(getData(member));
              else
                  vecTrans = getData(member, str2num(numTrans));
              end
              
              x = 1:length(vecTrans);
              subplot(2,1,1)
              bar(x,vecTrans);
              xlabel('# of Transactions')
              ylabel('Balance')
              
              %anonymous function to get all the stats at once
              getStat = @(vec)[mean(vec), median(vec), mode(vec), max(vec), min(vec)];
              
              statsTrans  = getStat(vecTrans);
              wmean = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.2 0.4 0.5 0.08],'BackgroundColor','w','ForegroundColor','b','String',sprintf('mean: $%.2f',statsTrans(1)),'FontSize',40);
              wmedian = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.2 0.3 0.5 0.08],'BackgroundColor','w','ForegroundColor','b','String',sprintf('median: $%.0f',statsTrans(2)),'FontSize',40);
              wmode = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.2 0.2 0.5 0.08],'BackgroundColor','w','ForegroundColor','b','String',sprintf('mode: $%.0f',statsTrans(3)),'FontSize',40);
              wmax = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.2 0.1 0.5 0.08],'BackgroundColor','w','ForegroundColor','b','String',sprintf('max balance: $%.0f',statsTrans(4)),'FontSize',40);
              wmin = uicontrol('Style','text','Visible','off','Units','normalized','Position',[0.2 0.0 0.5 0.08],'BackgroundColor','w','ForegroundColor','b','String',sprintf('min balance: $%.0f',statsTrans(5)),'FontSize',40);
              set([wmean,wmedian,wmode,wmax,wmin],'Visible','on')
              

              else
              
                  f10 = figure('Visible','on','Units','normalized','Position',[0.5 0.3 0.5 0.4],'Color','w','Name','A$$YL BANK');
                  werrorcheck = uicontrol('Style','text','Visible','on','Units','normalized','Position',[0.1 0.2 0.8 0.5],'BackgroundColor','w','ForegroundColor','r','String',sprintf('Please enter a valid number'),'FontSize',50);
              end 
        end
    
       % output the corresponding user's transactions as a vector
    function out = getData(mem, varargin)
        fid = fopen('Bankdata.dat');

        data = cell(1,numMember);
        for i = 1: numMember
           data{i} = fgetl(fid);
        end
        
        
        b = fclose(fid);
        if b~=0
            disp('File close not successful')
        end   
        
        profile = data{mem};
        [title, rest1] = strtok(profile);
        [nfirst, rest2] = strtok(strtrim(rest1)); 
        [nlast, rest3] = strtok(strtrim(rest2));
        [~, Trans] = strtok(strtrim(rest3));
       
        vec = str2num(strtrim(Trans));
        switch nargin
            case 1
                out = vec;
            case 2
                out = vec((length(vec)-varargin{1}+1):end);
        end
    end
    
end
