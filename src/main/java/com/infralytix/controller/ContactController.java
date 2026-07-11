package com.infralytix.controller;

import com.infralytix.dto.ContactFormDto;
import com.infralytix.service.ContactService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class ContactController {

    private final ContactService contactService;

    @GetMapping("/contact")
    public String contact(Model model) {
        model.addAttribute("pageTitle", "Contact");
        model.addAttribute("activePage", "contact");
        model.addAttribute("contactForm", new ContactFormDto());
        return "contact";
    }

    @PostMapping("/contact")
    public String submitContact(
            @Valid @ModelAttribute("contactForm") ContactFormDto contactForm,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("pageTitle", "Contact");
            model.addAttribute("activePage", "contact");
            return "contact";
        }

        contactService.submitContactForm(contactForm);
        redirectAttributes.addFlashAttribute("successMessage",
                "Thank you! Your message has been sent successfully. We will get back to you soon.");
        return "redirect:/contact";
    }
}
