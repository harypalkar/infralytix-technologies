package com.infralytix.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BlogPost {

    private String title;
    private String excerpt;
    private String date;
    private String category;
    private String image;
}
