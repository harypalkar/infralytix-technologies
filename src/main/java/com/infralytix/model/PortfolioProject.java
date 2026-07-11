package com.infralytix.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PortfolioProject {

    private String title;
    private String description;
    private String image;
    private String[] technologies;
}
