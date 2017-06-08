$('#editor').trumbowyg({
    // btns: ['strong', 'em', '|', 'insertImage'],
    btns: [
        ['formatting'],
        // 'btnGrp-semantic',
        'textformat',
        ['link'],'|',
        'textposition',
        // ['insertImage'],
        // 'btnGrp-justify',
        'justifydrop',
        'listdrop',
        ['preformatted'],
        // 'btnGrp-lists',
        ['horizontalRule'],
        ['removeformat'],
        ['viewHTML'],
        ['fullscreen']
        // ['template'],
    ],
    btnsDef: {
        justifydrop: {
            dropdown: ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'],
            ico: "justifyCenter"
        },
        listdrop: {
            dropdown: ['unorderedList', 'orderedList'],
            ico: "unorderedList"
        },
        textposition: {
            dropdown: ['superscript', 'subscript'],
            ico: "superscript"
        },
        textformat: {
            dropdown: ['bold', 'italic', 'strikethrough'],
            ico: "bold"
        }
    },
    plugins: {
        templates: [
            {
                name: 'Template 1',
                html: '<p>I am a template!</p>'
            },
            {
                name: 'Template 2',
                html: '<p>I am a different template!</p>'
            }
        ]
    },
    svgPath: '/css/icons.svg',//false
    semantic: true,//strong, em instead of b i
    resetCss: false,//reset css in editor,
    removeformatPasted: true,
    autogrow: false//adust to text size
});
