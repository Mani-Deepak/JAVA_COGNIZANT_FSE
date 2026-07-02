interface Document {
    void createDocument();
}

class WordDocument implements Document {
    @Override
    public void createDocument() {
        System.out.println("Creating a Word Document");
    }
}

class PDFDocument implements Document {
    @Override
    public void createDocument() {
        System.out.println("Creating a PDF Document");
    }
}

class ExcelDocument implements Document {
    @Override
    public void createDocument() {
        System.out.println("Creating an Excel Document");
    }
}

class DocumentFactory {

    public Document createDocument(String type) {

        if (type.equalsIgnoreCase("WORD")) {
            return new WordDocument();
        }

        if (type.equalsIgnoreCase("PDF")) {
            return new PDFDocument();
        }

        if (type.equalsIgnoreCase("EXCEL")) {
            return new ExcelDocument();
        }

        throw new IllegalArgumentException("Invalid document type");
    }
}

// Factory class

class Factory {
    public static void main(String[] args) {
        DocumentFactory factory = new DocumentFactory();

        Document wordDoc = factory.createDocument("WORD");
        wordDoc.createDocument();

        Document pdfDoc = factory.createDocument("PDF");
        pdfDoc.createDocument();

        Document excelDoc = factory.createDocument("EXCEL");
        excelDoc.createDocument();
    }
}