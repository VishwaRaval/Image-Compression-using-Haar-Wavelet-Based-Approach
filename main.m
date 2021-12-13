function varargout = main(varargin)
% MAIN M-file for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDEs Tools menu.  Choose "GUI allows only one instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 30-Oct-2020 12:17:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse_Image.
function Browse_Image_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%code for the browising the image (random input) and "uigetfile()", a matlab library
%function used for getting the location data of image and if statement is
%used to ensure that image with ".jpg" extention is taken as input.
handles.output = hObject;
[filename,pathname]=uigetfile('*.jpg');
if ~filename
    errordlg('Select an Image File.');
     return;
end
a=imread(strcat(pathname,filename)); %image is browsed and stored in the value a
a=imresize(a,[512 512]);
handles.my_data=a; 

guidata(hObject, handles);
b=strcat(pathname,filename); %assigning the location of the file for plotting it
axes(handles.Image_in)
imshow(b); %plotting the original function using the MATLAB library "plot" function. 

%show original image size
fileinfo = dir(b);
SIZE = fileinfo.bytes; % "filename".bytes is used to get the size of the original image in bytes
size=SIZE/1024; % converting the size of image in kilobytes
set(handles.size1,'string',size); %assigning the size of original image to display it on screen

% --- Executes on button press in Press_for_haar.
function Press_for_haar_Callback(hObject, eventdata, handles)
% hObject    handle to Press_for_haar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=handles.my_data; %assigning 'a' the information of original image

[v,w]=haar_DWT(a); %calling the function "haar.m" to perform the haar wavlet transformation

handles.my_out=v; 
handles.w=w;
guidata(hObject,handles); %plotting the compressed image 
axes(handles.image_out);
axis off;
axes(handles.image_out);
imshow(handles.my_out);



% --- Executes on button press in press_for_LL_pixels.
function press_for_LL_pixels_Callback(hObject, eventdata, handles)
% hObject    handle to press_for_LL_pixels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.my_out=handles.w;
axes(handles.image_out);    %now for viewing the compressed image on full screen plotting the LL pixels 
                                                 %image
axis off;
axes(handles.image_out);
imshow(handles.my_out);

j=handles.my_data; 
k=handles.my_out;

[PSNR]=quality_meausre(j,k);   %showing the image quality using the PSNR function defined 

set(handles.text16,'string',PSNR);

% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%closing the graphical user interface
close all;  
clc;


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)


toBeSaved=handles.w;   
assignin('base','toBeSaved',toBeSaved); %using library function to allow user to save the compressed image 
[fileName, filePath]=uiputfile('*.jpg', 'Save toBeSaved as');
fileName = fullfile(filePath, fileName);
imwrite(toBeSaved, fileName, 'jpg'); % using "imwrite" library function 
guidata(hObject, handles);

%Show compressed image size 
fileinfo = dir(fileName);
SIZE1 = fileinfo.bytes;
size1=SIZE1/1024;
set(handles.size2,'string',size1);


% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function e1_Callback(hObject, eventdata, handles)
fileinfo = dir(lhandles.my_data);
filesize = fileinfo(1).bytes;
set(handles.e1,'String',filesize);
% hObject    handle to e1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e1 as text
%        str2double(get(hObject,'String')) returns contents of e1 as a double


% --- Executes during object creation, after setting all properties.
function e1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e2_Callback(hObject, eventdata, handles)

        

fileinfo1 = dir(lhandles.my_data);
filesize1 = fileinfo1(1).bytes;
set(handles.e2,'String',filesize1);
% hObject    handle to e2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e2 as text
%        str2double(get(hObject,'String')) returns contents of e2 as a double


% --- Executes during object creation, after setting all properties.
function e2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)

%function for comparative analysis of Haar wavlet with DCT transformation 
g=handles.my_data; 
[m]=haar_wavelet(g); %using library function to call the DCT transform
axes(handles.image_dct);%showing the DCT image for comparing with Haar Wavelet Compressed Image.
imshow(m);

guidata(hObject, handles);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)


% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
